# Meetings Guide — Ascendra

> **Purpose**: Overview of the meetings module architecture, 100ms integration, and attendance tracking.

---

## 1. Core Concepts

The Meetings feature handles scheduling, live video conferencing, attendance tracking, and replays.

### Key Entities
- **Meeting**: The scheduled event (title, description, start time, attendees).
- **Meeting Session**: An active instance of a meeting (linked to a 100ms room).
- **Meeting Attendance**: Tracks when users join and leave the active session.

## 2. The 100ms Integration

Ascendra uses the **100ms SDK** for WebRTC video conferencing.

### Room Creation (Edge Function)
Flutter NEVER creates 100ms rooms directly.
When a leader taps "Start Meeting":
1. Flutter calls the `schedule-meeting` Supabase Edge Function.
2. The Edge Function calls the 100ms API to create a room.
3. The Edge Function saves the `room_id` and `customer_id` into the `meeting_sessions` table.
4. It returns the 100ms auth token to Flutter.

### Joining a Room (Flutter)
1. Flutter calls `join_meeting_session()` RPC.
2. Flutter initializes the `HMSSDK`.
3. Flutter joins the room using the token.

## 3. Attendance Tracking

Attendance is tracked automatically without manual input from leaders.

### Webhook Driven
1. When a user joins or leaves a room, 100ms fires a webhook.
2. The Supabase Edge Function (`100ms-webhook`) receives this and updates `meeting_attendance` (setting `joined_at` or `left_at`).

### The 70% Rule
When the meeting ends, a NestJS worker calculates attendance. A member is marked as "Attended" only if their total time in the room is $\ge$ 70% of the meeting's duration.

## 4. Replay and AI Summaries

### Meeting Replay
1. 100ms automatically records the meeting (if configured in the 100ms template).
2. When the recording completes, a webhook fires.
3. NestJS updates the `meetings.recording_url`.
4. Flutter uses `video_player` to stream the replay.

### AI Summary
1. NestJS fetches the transcript from 100ms (or generates it via a Whisper API).
2. NestJS sends the transcript to Gemini with a prompt to summarize key action items.
3. The summary is saved to the `meetings` table.

## 5. Flutter Architecture

### Replay Refactor Rule
The presentation layer does not assemble replay data. 
`MeetingReplayProvider` $\rightarrow$ `MeetingReplayRepository` $\rightarrow$ `MeetingRepository` / `ProfileRepository`.
Widgets receive a single, combined `MeetingReplayViewModel`.
