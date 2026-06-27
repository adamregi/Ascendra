# Ascendra API Contract

This document serves as the definitive API contract for the Ascendra backend. All Flutter clients must adhere to these conventions.

## 1. Global Error Model

All Edge Functions and backend services must catch exceptions and return a normalized JSON payload for errors.
PostgreSQL exceptions (e.g., from RPCs) are mapped into this structure by the calling edge function or Supabase client wrapper.

```json
{
  "success": false,
  "code": "ERROR_CODE",
  "message": "Human-readable message explaining the error.",
  "details": {} // Optional debugging payload
}
```

### Standard Error Codes
- `UNAUTHORIZED`: Request lacked valid authentication credentials.
- `PERMISSION_DENIED`: User does not have privileges for this action.
- `NOT_FOUND`: The requested resource does not exist.
- `VALIDATION_FAILED`: The payload was rejected due to schema violations.
- `BUSINESS_RULE_VIOLATION`: An action was prevented by core logic (e.g., terminating an already terminated member).
- `INTERNAL_SERVER_ERROR`: Unhandled exception.

---

## 2. Pagination Strategy

All endpoints and views returning collections (e.g., Alerts, Automation Logs, History) support standard limit/offset pagination. 
When using the Supabase Flutter client, pagination is handled via standard query modifiers:

```dart
final response = await supabase
  .from('alerts')
  .select()
  .eq('company_id', userCompanyId)
  .order('created_at', ascending: false)
  .range(offset, offset + limit - 1);
```

For custom RPCs returning sets, pass `p_limit` and `p_offset` if exposed, or rely on the edge function to paginate the response.

---

## 3. Core RPC Endpoints

These are the primary business logic endpoints currently frozen in the backend.

### `get_executive_brief_data(p_company_id)`
Retrieves the daily top alerts and stats for the executive dashboard.
- **Method**: RPC
- **Returns**: JSON object containing `top_alerts` and `stats`.
- **Note**: Does not use pagination as it is strictly the Top 5.

### `route_skill(p_company_id, p_question)`
Determines the best AI skill handler for a given natural language input.
- **Method**: RPC
- **Returns**: JSON object with routing decisions.

### `run_decision_engine()`
Manually triggers the evaluation of operational snapshots against `alert_rules`.
- **Method**: RPC (Cron scheduled)
- **Returns**: Void.

### `submit_task_proof(p_assignment_id, p_proof_type, p_comment, p_file_url)`
Logs completion of a task assignment.
- **Method**: RPC
- **Returns**: JSON object of the updated assignment.

### `terminate_member(p_profile_id, p_leader_id, p_reason)`
Processes a member termination and cleans up upline/downline relationships.
- **Method**: RPC
- **Returns**: JSON object representing the termination log.
