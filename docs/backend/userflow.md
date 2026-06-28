# Ascendra Backend User Flow Diagrams

This document contains flowcharts of core backend workflows, showing state transitions, validation checks, and asynchronous event-driven updates.

---

## 1. Member Onboarding & Invitation Flow

This flow diagram illustrates how invited members activate their account using phone-based OTP verification.

```mermaid
graph TD
    Start([User Clicks Invite Link / Input OTP]) --> EdgeCall[Invoke /accept-invitation Edge Function]
    EdgeCall --> VerifyInvite{Query Database:<br/>Is invitation_id valid & pending?}
    
    VerifyInvite -- No --> ErrorInvite[Return ERROR_CODE: NOT_FOUND / EXPIRED]
    VerifyInvite -- Yes --> VerifyOTP{Verify OTP code via Supabase Auth}
    
    VerifyOTP -- Failed --> ErrorOTP[Return ERROR_CODE: VALIDATION_FAILED]
    VerifyOTP -- Success --> CreateAuth[Generate GoTrue Auth User]
    
    CreateAuth --> TxStart[Start Database Transaction]
    TxStart --> LinkProfile[Link profiles.auth_user_id = auth.uid]
    LinkProfile --> ActivateProfile[Set profiles.status = 'active']
    ActivateProfile --> AcceptInvite[Set invitations.status = 'accepted']
    
    AcceptInvite --> TxCommit[Commit Transaction]
    TxCommit --> SessionToken[Generate & Return Session Token]
    SessionToken --> End([User Onboarded & Logged In])
```

---

## 2. AI Assistant RAG Chat Workflow (Phase F0)

This flowchart shows how semantic queries, database lookups, and Gemini API calls are coordinated with context logging in the NestJS application layer.

```mermaid
graph TD
    Start([Leader/Member Types Question]) --> NestCall[Invoke /ai-chat NestJS Endpoint]
    NestCall --> GetEmbedding[Generate query embedding vector]
    GetEmbedding --> VectorQuery[Semantic search in document_chunks using pgvector]
    VectorQuery --> ContextQuery[Fetch company rules and user compliance snapshots]
    
    ContextQuery --> PromptBuilder[Assemble Prompt Template:<br/>System Rules + Retrieved Chunks + Context Snapshot + User Query]
    PromptBuilder --> HashPrompt[Compute SHA-256 hash of prompt]
    
    HashPrompt --> CallGemini[Call Gemini API]
    CallGemini --> NormalizeRole[Map Gemini role 'model' to 'assistant']
    
    NormalizeRole --> TxStart[Start Database Transaction]
    TxStart --> InsertMsg[Insert user & assistant messages into ai_messages]
    InsertMsg --> LogContext[Log prompt hash, similarity scores, and sources in ai_context_logs]
    LogContext --> LogUsage[Log token count and latency in ai_usage_logs]
    
    LogUsage --> TxCommit[Commit Transaction]
    TxCommit --> SendResponse[Send answer and sources to Flutter app]
    SendResponse --> End([Conversation UI Updated])
```

---

## 3. Decision & Alert Engine Flow

This flowchart shows how rules are processed, alerts are deduplicated, and notifications are sent asynchronously through our Event Bus.

```mermaid
graph TD
    Start([Daily Cron runs in NestJS]) --> ClearExpired[Set expired alerts status = 'Expired']
    ClearExpired --> FetchRules[Query enabled alert_rules]
    
    FetchRules --> RuleLoop{Process next rule}
    RuleLoop -- Done --> End([Alert processing cycle complete])
    
    RuleLoop -- Active Rule --> QueryMetrics[Query metric view:<br/>e.g. member_risk_scores / mv_leadership_pipeline]
    QueryMetrics --> CompareThreshold{Check if value matches threshold}
    
    CompareThreshold -- No --> RuleLoop
    CompareThreshold -- Yes --> GenHash[Generate unique hash:<br/>md5 company_id + profile_id + rule_id + week]
    
    GenHash --> InsertAlert[Insert alert into alerts table]
    InsertAlert --> OnConflict{Check for hash conflict}
    
    OnConflict -- Yes (Exists) --> LogSkip[Skip insert] --> RuleLoop
    OnConflict -- No (New) --> CreateAlert[Alert created]
    
    CreateAlert --> PublishAlertEvent[Publish 'AlertGenerated' Event to Event Bus]
    PublishAlertEvent --> LogAuto[Log execution in automation_logs]
    
    %% Async consumer flow
    PublishAlertEvent -.->|Async Queue| QueueConsumer[Queue Consumer]
    QueueConsumer --> CheckPref[Query target alert_preferences]
    CheckPref --> NotificationService[NotificationService Abstraction]
    NotificationService --> DispatchDelivery[Dispatch Delivery: WhatsApp / FCM Push / Email]
    
    LogAuto --> RuleLoop
```

---

## 4. Compliance Warning & Event-Driven Restructuring

This flowchart shows how non-compliant behavior triggers warnings and terminations, and how hierarchy restructuring is offloaded to background queues.

```mermaid
graph TD
    Start([Compliance audit cron runs in NestJS]) --> ScanProgress[Scan mv_member_progress metrics]
    ScanProgress --> EvalCompliance{Is member compliant?}
    
    EvalCompliance -- Yes --> End([No action taken])
    EvalCompliance -- No --> WarnStatus{Check current profile status}
    
    WarnStatus -- 'active' --> IssueWarning[Set status = 'warned'<br/>Insert compliance_events<br/>Trigger NotificationService Alert]
    IssueWarning --> GracePeriod[Start grace period timer]
    
    WarnStatus -- 'warned' and Grace Expired --> SuspendMember[Set status = 'suspended'<br/>Block feature access]
    
    WarnStatus -- 'suspended' and Ext. Violation --> TerminateMember[Leader triggers terminate_member RPC]
    
    TerminateMember --> TxStart[Start Database Transaction]
    TxStart --> SetTerminated[Set profiles.status = 'terminated'<br/>Disable auth user account]
    SetTerminated --> TxCommit[Commit Transaction]
    
    TxCommit --> PublishTermEvent[Publish 'MemberTerminated' Event to Event Bus]
    
    %% Async restructuring consumer
    PublishTermEvent -.->|Restructure Queue| RestructureConsumer[Restructure Consumer]
    RestructureConsumer --> CallRestructureRPC[Call RPC restructure_network_tree]
    CallRestructureRPC --> FindChildren[Fetch downline children via get_descendants]
    
    FindChildren --> MoveChildren[Update parent_id to terminated member's parent]
    MoveChildren --> RecalculatePaths[Update path and path_ltree recursively]
    
    RecalculatePaths --> WriteAudits[Write restructure_logs & termination_logs]
    WriteAudits --> End
```
