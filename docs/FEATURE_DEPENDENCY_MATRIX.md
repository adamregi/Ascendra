# Feature Dependency Matrix — Ascendra

> **Purpose**: A matrix mapping features to their upward and downward dependencies. Essential for planning cross-module impact.

---

## The Matrix

| Feature | Depends On (Requires) | Used By (Impacts) |
|---------|-----------------------|-------------------|
| **Auth** | - | *Every Module* |
| **Members** | `Auth`, `Network` | `Dashboard`, `Meetings`, `Tasks`, `Compliance` |
| **Tasks** | `Auth`, `Members`, `Storage` | `Dashboard`, `Compliance` |
| **Meetings** | `Auth`, `Members`, `100ms` | `Dashboard`, `Compliance` |
| **Compliance** | `Tasks`, `Meetings`, `Members`| `Members` (UI badges) |
| **Dashboard** | `Tasks`, `Meetings`, `Members` | - |
| **AI Assistant** | `Auth`, `Knowledge (RAG)` | - |

## How to Read This Matrix

- **Depends On**: If you change the API or data model of a feature in this column, you MUST check the current Feature. (e.g., Changing `Members` can break `Meetings`).
- **Used By**: If you change the current Feature, you MUST check all features in this column. (e.g., Changing `Tasks` can break the `Dashboard` aggregations).
