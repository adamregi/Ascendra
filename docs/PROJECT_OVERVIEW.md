# Project Overview — Ascendra

> **Product Name**: Ascendra
> **Package Name**: `distributor_os`
> **Category**: MLM Leadership SaaS Platform
> **Primary Platform**: Android (Flutter)

---

## What Is Ascendra?

Ascendra is a **leader-centric MLM management platform** designed for network marketing organizations. It replaces scattered tools (WhatsApp groups, spreadsheets, manual attendance) with a unified command center.

## Problem Statement

Network marketing leaders manage teams of 50–200 members using fragmented, manual processes:

- **Meetings** are tracked via WhatsApp attendance calls
- **Task completion** is verified through screenshots shared in group chats
- **Compliance** is monitored through periodic manual audits
- **New member onboarding** is handled through phone calls and paper forms
- **Performance analytics** are compiled manually in spreadsheets

Ascendra eliminates all of this with automated, real-time tracking.

## Core Capabilities

### 1. Team Management
- Invite members via phone-based OTP verification
- View member profiles with compliance, tasks, meetings, and recognition
- Directory with search, filtering, and risk indicators
- Network tree visualization (ltree-powered hierarchy)

### 2. Video Meetings
- Live video meetings powered by 100ms SDK
- Automatic attendance tracking with join/leave timestamps
- AI-generated meeting summaries (Gemini + RAG)
- Meeting replay with attendance reports

### 3. Task Operations
- Create and assign tasks with priorities and due dates
- Multi-type proof submission (text, URL, image, PDF)
- Leader review workflow (approve/reject)
- Automated follow-up reminders

### 4. Compliance Monitoring
- Configurable compliance rules per company
- Automated scoring (attendance, task completion, follow-ups)
- Warning and suspension workflows
- Compliance violation tracking with explainability

### 5. AI Leadership Coach
- RAG-powered chatbot using company-specific documents
- pgvector for semantic search across knowledge base
- Context-aware responses using meeting history, task data, and compliance records
- Usage tracking and cost monitoring

### 6. Executive Dashboard
- Real-time KPIs from materialized views
- Leadership pipeline analysis
- Growth analytics
- AI-powered recommendations

## Business Model

Ascendra operates on a **B2B SaaS subscription model**:

| Plan | Member Limit | Price |
|------|-------------|-------|
| Starter | 50 | Base tier |
| Pro | 100 | Mid tier |
| Enterprise | 200 | Full features |

Leaders purchase subscriptions. Members are invited — they do not self-register or pay.

## User Roles

### Leader
- Full platform access
- Manages members, meetings, tasks, compliance, AI, settings
- Purchases and manages subscriptions
- Can invite new members (within plan limits)
- Can warn, suspend, and terminate members

### Member
- Limited access
- Attends meetings, completes tasks
- Views own compliance status
- Can chat with AI assistant
- Cannot invite other members

## Profile Lifecycle

```
invited → active → warned → suspended → terminated
                     ↑          ↓
                     └── active ←┘ (reinstated)
```

## Onboarding Flow

```
Leader invites member (name, phone, distributor ID)
    ↓
System checks subscription limit
    ↓
Profile created (status: invited)
Invitation created (status: pending)
    ↓
SMS sent with OTP link
    ↓
Member verifies phone via OTP
    ↓
Member sets password
    ↓
Supabase auth account linked
Profile status → active
Invitation status → accepted
```

## Non-Goals

- Ascendra does NOT handle financial transactions or commission calculations
- Ascendra does NOT replace CRM systems
- Ascendra does NOT support social media features
- Ascendra does NOT allow self-registration
- Ascendra does NOT process payments directly (subscription management is external)

---

*See also: [BUSINESS_RULES.md](BUSINESS_RULES.md), [PROJECT_ARCHITECTURE.md](PROJECT_ARCHITECTURE.md)*
