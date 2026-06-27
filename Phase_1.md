# ROLE

You are a Principal Staff Engineer, Solutions Architect, and Supabase Expert.

Build a complete production-ready backend for the Ascendra MLM Leadership Platform.

Frontend already exists in Flutter.

Your responsibility is ONLY backend architecture, database design, security, APIs, business logic, realtime events, AI integration, compliance engine, meeting system, and infrastructure.

Do not generate toy examples.

Generate enterprise-grade code.

---

# PLATFORM OVERVIEW

Ascendra is an MLM Leadership SaaS platform.

Primary goals:

* Team management
* Member hierarchy management
* Compliance tracking
* Meeting attendance tracking
* AI leadership assistant
* Automated warnings
* Automated termination workflows
* Downline restructuring
* Company-level multi-tenancy
* Scalable to 100,000+ users

Frontend:

* Flutter
* Riverpod
* Clean Architecture

Backend Stack:

* Supabase

  * PostgreSQL
  * Auth
  * Storage
  * Realtime
  * RLS

* NestJS

  * REST APIs
  * BullMQ jobs
  * Background processing

* Redis

  * Upstash Redis

* 100ms

  * Meetings

* Gemini API

  * AI Assistant

Infrastructure:

* Railway deployment
* Supabase Free Tier initially

---

# IMPORTANT

Follow Clean Architecture.

Use:

Domain Layer
Application Layer
Infrastructure Layer
Presentation Layer

Never create massive services.

Use feature-first modular architecture.

---

# REQUIRED MODULES

Generate all backend code for:

1. Authentication
2. Profiles
3. Companies
4. Invitations
5. Members
6. Network Tree
7. Meetings
8. Attendance
9. Compliance
10. Warnings
11. Terminations
12. Restructuring
13. Notifications
14. File Storage
15. AI Assistant
16. Analytics
17. Background Jobs
18. Audit Logs

---

# DATABASE DESIGN

Create complete PostgreSQL schema.

Use UUIDs everywhere.

Generate:

Tables
Indexes
Constraints
Triggers
Views

---

# MULTI TENANCY

System is company-based.

Every record belongs to:

company_id

Requirements:

* Complete tenant isolation
* RLS on every table
* Users can only access their company data

Generate:

Policies
Security Functions
Helper SQL

---

# USER ROLES

Leader

Member

Capabilities:

Leader:

* create meetings
* invite members
* manage compliance
* terminate members
* view analytics
* use AI assistant

Member:

* join meetings
* view compliance
* receive warnings
* chat with AI

---

# CORE TABLES

Generate schema for:

profiles

companies

company_settings

invitations

memberships

network_nodes

meetings

meeting_participants

attendance_records

compliance_rules

compliance_snapshots

warnings

termination_logs

restructure_logs

notifications

documents

ai_conversations

ai_messages

audit_logs

---

# NETWORK TREE ENGINE

Most important part.

Build MLM hierarchy system.

Requirements:

Each member has:

parent_id

company_id

user_id

Generate:

NetworkNode entity

Features:

* add member
* move member
* terminate member
* calculate depth
* calculate subtree size
* retrieve descendants
* retrieve ancestors

Use PostgreSQL recursive CTEs.

Generate optimized SQL.

Must support:

100,000+ nodes

---

# INVITATION SYSTEM

Screen Flow:

Leader generates invite.

Invite contains:

id
code
expires_at
created_by
company_id

Requirements:

Generate:

invite-member endpoint

accept-invitation endpoint

validation service

expiration checks

QR-compatible invite links

---

# AUTHENTICATION

Use Supabase Auth.

Generate:

create-profile flow

Google OAuth

Email/password

Phone OTP

Role assignment

Profile creation trigger

On signup:

Create profile automatically.

---

# COMPANY CREATION

Leader creates company.

Generate:

Company aggregate

Company service

Slug uniqueness validation

Company settings initialization

Default compliance rules creation

---

# MEETING SYSTEM

Support all screens:

Schedule Meeting

Live Meeting

Replay

Attendance

Meeting Reports

Use 100ms.

Generate:

meeting entity

meeting lifecycle

scheduled

live

ended

cancelled

meeting recordings

meeting analytics

---

# ATTENDANCE ENGINE

Track:

join_time

leave_time

duration_minutes

Requirements:

Automatic attendance calculation.

Generate:

attendance service

attendance aggregation SQL

attendance summary jobs

---

# COMPLIANCE ENGINE

This is the platform core.

Rules:

meetings_required_per_month

minimum_duration

grace_period_days

auto_terminate

Generate:

ComplianceRule entity

ComplianceCalculator service

Monthly evaluation engine

ComplianceSnapshot generation

Statuses:

COMPLIANT

WARNED

AT_RISK

TERMINATED

---

# WARNING ENGINE

Generate:

send-warning endpoint

warning templates

notification creation

warning history

audit logging

Background job support.

---

# TERMINATION ENGINE

Most critical workflow.

Requirements:

Terminate member

Select reassignment target

Move downline

Preserve hierarchy integrity

Log everything

Generate:

terminate-member use case

restructure-tree use case

transaction-safe implementation

rollback strategy

---

# RESTRUCTURE ENGINE

When member terminated:

children reassigned

Generate:

recursive hierarchy update

subtree movement

consistency checks

transaction boundaries

---

# ANALYTICS ENGINE

Generate:

monthly attendance

compliance rates

active members

meeting statistics

top performers

dashboard aggregations

optimized SQL views

materialized views where needed

---

# NOTIFICATIONS

Types:

warning

meeting_reminder

meeting_started

compliance_update

termination_notice

Generate:

notification service

realtime events

Supabase Realtime integration

---

# FILE STORAGE

Use Supabase Storage.

Support:

company logos

documents

meeting assets

Generate:

upload-document endpoint

signed URL generation

access policies

---

# AI ASSISTANT

Use Gemini.

Generate:

ai-chat endpoint

conversation storage

message history

RAG-ready architecture

Future vector support.

Design for:

pgvector later

without breaking schema.

---

# AUDIT LOGGING

Every critical action must create logs.

Track:

actor

target

action

before

after

timestamp

Generate:

AuditLog entity

Audit middleware

Audit service

---

# BACKGROUND JOBS

Use BullMQ.

Queues:

compliance-check

termination-check

meeting-reminders

attendance-processing

notification-delivery

analytics-refresh

Generate:

queue architecture

workers

retry policies

dead letter strategy

---

# API DESIGN

Generate complete REST API.

Include:

Auth

Meetings

Members

Compliance

Warnings

Invitations

AI

Analytics

Notifications

For every endpoint provide:

Method

Path

Request DTO

Response DTO

Validation

Authorization

---

# PERFORMANCE

Optimize for:

100,000 users

Large network trees

Large attendance datasets

Requirements:

Indexes

Caching

Redis strategy

Pagination

Cursor pagination

Query optimization

N+1 prevention

---

# SECURITY

Generate:

RLS

JWT validation

Role guards

Input validation

Rate limiting

Audit trails

Storage security

OWASP protections

---

# DELIVERABLE FORMAT

Produce output in this exact order:

1. System Architecture Diagram
2. Module Structure
3. Database Schema
4. SQL Migrations
5. RLS Policies
6. NestJS Folder Structure
7. Domain Models
8. Use Cases
9. Services
10. Repositories
11. REST APIs
12. DTOs
13. Background Jobs
14. Redis Strategy
15. Realtime Events
16. Gemini Integration
17. 100ms Integration
18. Security Design
19. Deployment Architecture
20. Scalability Plan
21. Production Readiness Checklist

Generate actual implementation code wherever possible.

Do not provide summaries.

Produce production-grade backend code and architecture.
