# Ascendra API Models (DTOs)

This document defines the single source of truth for Data Transfer Objects (DTOs) across the Ascendra application. 
Flutter models (using `Freezed` and `json_serializable`) must be generated against these shapes to ensure contract stability.

## 1. Executive Dashboard Models

### `ExecutiveBriefData`
Returned by `get_executive_brief_data()` and used to populate the Leader's morning summary.

```json
{
  "top_alerts": [
    {
      "id": "uuid",
      "type": "High Risk",
      "severity": "Critical",
      "title": "Risk Alert: John Doe",
      "created_at": "2026-06-25T01:30:00Z"
    }
  ],
  "stats": {
    "high_risk_count": 2,
    "promotion_count": 1,
    "recognition_count": 3
  }
}
```

### `ExecutiveOverview` (Materialized View row)
Represents the rolled-up health for an entire company/team.

```json
{
  "company_id": "uuid",
  "team_health_score": 87.5,
  "team_size": 150,
  "active_members": 142,
  "team_attendance_rate": 92.4,
  "team_completion_rate": 88.1,
  "team_growth_score": 12.3,
  "task_growth_score": 5.4,
  "low_risk_count": 100,
  "medium_risk_count": 30,
  "high_risk_count": 10,
  "critical_risk_count": 2,
  "risk_percentage": 8.4,
  "future_leaders": 5,
  "emerging_leaders": 12,
  "developing_members": 80,
  "needs_development": 45,
  "generated_at": "2026-06-25T01:00:00Z"
}
```

## 2. Intelligence & Alerting Models

### `Alert`
Represents an actionable intelligence event.

```json
{
  "id": "uuid",
  "company_id": "uuid",
  "profile_id": "uuid",
  "rule_id": "uuid",
  "alert_hash": "string",
  "type": "Promotion",
  "severity": "High",
  "status": "Unread",
  "title": "Promotion Candidate: Jane Doe",
  "description": "Leadership score reached 95.",
  "metadata": {},
  "created_at": "timestamp",
  "valid_until": "timestamp",
  "resolved_at": null
}
```

### `Recommendation`
Output from the `mv_recommendation_center`.

```json
{
  "recommendation_id": "uuid",
  "profile_id": "uuid",
  "member_name": "Jane Doe",
  "recommendation_type": "promotion",
  "recommended_role": "Team Leader",
  "confidence_score": 92.5,
  "reasoning": {
    "factors": ["Consistently high task completion", "Leadership score > 90"]
  },
  "status": "pending",
  "created_at": "timestamp"
}
```

## 3. Operational Models

### `MemberProfile`
Standard representation of a user in the system.

```json
{
  "id": "uuid",
  "company_id": "uuid",
  "full_name": "John Doe",
  "role": "member",
  "status": "active",
  "distributor_id": "DIST-12345",
  "email": "john@example.com",
  "phone": "+1234567890",
  "created_at": "timestamp"
}
```

### `TaskAssignment`

```json
{
  "id": "uuid",
  "task_id": "uuid",
  "assignee_id": "uuid",
  "assigner_id": "uuid",
  "status": "pending",
  "due_date": "2026-07-01T00:00:00Z",
  "completed_at": null,
  "proof_required": true,
  "proof_submitted": false
}
```

## 4. AI Interaction Models

### `AIRoutingDecision`
Output of `route_skill()`.

```json
{
  "skill": "decision_advisor",
  "primary": "decision_advisor",
  "confidence": 0.95,
  "routing_reason": "Matched: prioritize.*alerts (8)",
  "alternatives": ["executive_briefing"],
  "needs_clarification": false
}
```
