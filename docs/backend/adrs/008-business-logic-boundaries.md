# ADR 008: SQL vs. NestJS Business Logic Boundaries

## Status
Accepted

## Context
In early phases, placing business logic in PostgreSQL stored procedures (RPCs) and triggers is a common pattern that speeds up prototyping. However, as the application scales:
- SQL triggers and procedures become difficult to version, rollback, and scale.
- Writing unit and integration tests for complex SQL loops (such as compliance calculations) is slow and hard to automate.
- Database servers become CPU-bound by application logic, rather than I/O-bound by data storage.

We need a clear contract to divide responsibilities between database-layer SQL and application-layer NestJS services.

## Decision
We decided to enforce a strict boundary between database operations and application business logic. 

1. **PostgreSQL Responsibilities (Keep in DB)**:
   - **Data Integrity**: Enforcing constraints (uniqueness, check constraints, foreign keys).
   - **Security**: Centralized multi-tenant isolation via Row-Level Security (RLS).
   - **Atomic Transactions**: Resolving circular dependencies during data creations (using deferred constraints).
   - **Heavy Data Calculations**: Tree traversals (`ltree`) and vector similarity searches (`pgvector`).
2. **NestJS Responsibilities (Move to Application Server)**:
   - **Business Rules**: Compliance checks, metrics scoring, and evaluation logic.
   - **Orchestration**: AI prompt generation, model routing, safety filtering, and telemetry logging.
   - **Side Effects**: Notification routing (FCM, SMS, email) and background task scheduling.
3. **Trigger Strategy**:
   - Triggers are restricted to data-sync tasks (e.g. mirroring a product table into documents). Evolving business rules are moved out of SQL triggers.

## Consequences

### Positive Impacts
- **Scalability**: Application logic scales horizontally in NestJS containers, reducing CPU load on the database.
- **Maintainability**: NestJS code is easier to version control, test, lint, and deploy without requiring database schema migrations.
- **Unified Services**: Simplifies notification handling by routing all user updates through a single service, rather than using SQL procedures.

### Trade-offs & Cons
- **Network Latency**: Moving logic to NestJS requires extra network hops between NestJS and PostgreSQL, which can add minor latency to complex transactions.
- **Hybrid transition**: Existing RPCs cannot be deleted immediately to avoid breaking the Flutter client. They are refactored into thin wrappers that call NestJS queues asynchronously.
