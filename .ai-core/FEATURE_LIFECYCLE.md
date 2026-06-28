# Feature Implementation Lifecycle — Ascendra

> **Purpose**: The strict sequence of steps required to implement a new feature from conception to completion. AI agents must follow this order to prevent architectural violations.

---

## 1. The Lifecycle Pipeline

```mermaid
graph TD
    %% Phase 1: Discovery
    Req[1. Requirement] --> Ref[2. Reference Screen]
    Ref --> Skills[3. Relevant Skills]
    Skills --> Arch[4. Architecture Review]

    %% Phase 2: Backend (Contract)
    Arch --> DB[5. Database & RLS]
    DB --> RPC[6. RPC / Backend]

    %% Phase 3: Data Layer
    RPC --> Models[7. Models (Freezed)]
    Models --> Repo[8. Repository]

    %% Phase 4: Presentation Layer
    Repo --> Provider[9. Provider]
    Provider --> Widgets[10. Widgets]

    %% Phase 5: Verification
    Widgets --> Tests[11. Tests]
    Tests --> Docs[12. Documentation]
    Docs --> Review[13. Code Review / Quality Gates]
    Review --> Done[14. Done]

    classDef phase1 fill:#e3f2fd,stroke:#1976d2,stroke-width:2px;
    classDef phase2 fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef phase3 fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef phase4 fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px;
    classDef phase5 fill:#ffebee,stroke:#d32f2f,stroke-width:2px;

    class Req,Ref,Skills,Arch phase1;
    class DB,RPC phase2;
    class Models,Repo phase3;
    class Provider,Widgets phase4;
    class Tests,Docs,Review,Done phase5;
```

## 2. Step Details

### 1. Discovery (Steps 1-4)
- **Requirement**: Understand the business need.
- **Reference Screen**: Look in `assets/reference/`. If building a UI, you MUST match the provided design. Do not invent layouts.
- **Relevant Skills**: Search the `Skills/` directory (using `.ai-core/SKILL_CATEGORIES.md`) for existing patterns.
- **Architecture Review**: Determine where the logic lives. Can this be a database RPC? Does it need an Edge Function? 

### 2. The Contract (Steps 5-6)
- **Database**: Add migrations and RLS policies.
- **RPC**: Create the Stored Procedure. This defines the JSON contract that Flutter will consume. **Never start Flutter UI before the RPC is defined.**

### 3. Data Layer (Steps 7-8)
- **Models**: Create immutable `Freezed` models matching the RPC JSON output. Run `build_runner`.
- **Repository**: Define the interface and implement the Supabase call in `lib/features/<feature>/data/repositories/`.

### 4. Presentation (Steps 9-10)
- **Provider**: Create the Riverpod provider using `@riverpod` and `ref.cacheFor`.
- **Widgets**: Build the UI. Extract reusable components into `widgets/`. **Widgets must not contain business logic.**

### 5. Verification (Steps 11-14)
- **Tests**: Write widget and unit tests.
- **Documentation**: Update `.ai-core/FEATURE_REGISTRY.md` and `docs/SCREEN_CATALOG.md`.
- **Quality Gates**: Pass all checks defined in `.ai-core/QUALITY_GATES.md` (Analyzer, Formatting, Responsiveness).
