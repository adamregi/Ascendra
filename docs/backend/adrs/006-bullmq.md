# ADR 006: Asynchronous Event Processing with BullMQ & Redis

## Status
Accepted

## Context
Many core backend operations in Ascendra trigger complex secondary tasks (side effects). For example:
- Ending a meeting triggers RAG summarization, attendee calculations, compliance checks, and dashboard view refreshes.
- Terminating a member requires finding descendants, reassigning uplines, recalculating paths, and logging audit logs.
- Assigning tasks requires generating and sending notifications across multiple channels (push, email, SMS).

Processing these workflows synchronously during API request-response loops increases client query times and risks timeouts. If a single downstream step fails (like a third-party notification call), it shouldn't cause the primary user action to fail.

## Decision
We decided to use **BullMQ** with **Upstash Redis** as our message broker to process background tasks asynchronously.

1. **Event Broker**: When a primary action succeeds, the API gateway publishes a domain event (`MeetingEnded`, `MemberTerminated`, `TaskCompleted`) to Upstash Redis.
2. **NestJS Consumers**: Deployed NestJS worker services to subscribe to queues and process tasks asynchronously.
3. **Queue Segmentation**: We separate tasks into dedicated queues (`onboarding-queue`, `meeting-evaluation-queue`, `compliance-queue`, `alert-dispatch-queue`) to isolate resource footprints.
4. **Retry Mechanism**: We use BullMQ's automatic retry and exponential backoff features to handle temporary failures, such as third-party API disconnects or database locks.

## Consequences

### Positive Impacts
- **Fast UI Response Times**: The client receives an immediate success response when an action is triggered, while heavy processing runs in the background.
- **Improved Reliability**: If a downstream task fails (e.g. a Twilio SMS gateway timeout), the primary transaction remains successful, and BullMQ retries the SMS job.
- **System Decoupling**: De-clutters controllers and database triggers by routing secondary side effects through event queues.

### Trade-offs & Cons
- **Infrastructure Dependency**: Adds Redis as a critical system dependency. If Redis is unavailable, background tasks will be delayed.
- **Event Ordering**: Processing tasks asynchronously means they can run out of order. The application must use database timestamps to ensure state updates are applied correctly.
- **Observability Overhead**: Requires adding queue monitoring (such as BullMQ dashboards or telemetry metrics) to track job execution times and catch stuck queues.
