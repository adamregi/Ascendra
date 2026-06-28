# Members Guide — Ascendra

> **Purpose**: Overview of the Member Profile architecture and the Tabbed View layout pattern.

---

## 1. Member Profile Layout

The Member Profile is the most complex UI in Ascendra. To keep the code maintainable, it uses a **Tabbed View** architecture.

### Structure
Instead of placing everything on a single scrolling page, the layout is:

```
Member Profile Page
│
├── Sticky Hero Section (Name, Avatar, Status)
│
└── TabBar / TabBarView
    ├── Overview Tab (KPIs, Recent Activity)
    ├── Timeline Tab (All events chronological)
    ├── Compliance Tab (Scores, violations)
    ├── Recognition Tab (Badges, leaderboards)
    └── Analytics Tab (Charts)
```

### Flutter Implementation
This is implemented using a `NestedScrollView` with a `SliverAppBar` (for the Hero) and a `TabBarView` (for the tabs).

## 2. API Contract & ViewModels

Flutter does NOT fetch meetings, tasks, and follow-ups separately and merge them.

The backend exposes a single RPC `get_member_profile_view_model(p_profile_id)`.

This returns a JSON object that maps to the following Freezed models:

```dart
@freezed
class MemberProfileViewModel with _$MemberProfileViewModel {
  const factory MemberProfileViewModel({
    required MemberHeroModel hero,
    required MemberKpiModel kpis,
    required List<MemberTimelineEventModel> recentTimeline,
    required MemberComplianceModel compliance,
  }) = _MemberProfileViewModel;
}
```

The tabs then extract their specific slice of data from this root model.

## 3. Directory Search

The Member Directory handles searching through a company's downline.

### Search Implementation
1. Flutter updates a `SearchQuery` Riverpod notifier as the user types (debounced).
2. A computed provider `filteredMembersProvider` watches both the raw data and the query.
3. The backend uses `pg_trgm` (trigram matching) for efficient text search in SQL if the search happens server-side, but typically for < 500 members, client-side filtering is preferred for responsiveness.

## 4. Status Terminology

- `invited`: Profile exists, OTP sent, user hasn't logged in yet.
- `active`: Normal state.
- `warned`: Compliance score dropped. Requires leader intervention.
- `suspended`: Blocked from meetings/tasks.
- `terminated`: Removed from the active downline.
