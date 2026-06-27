-- ============================================================================
-- Phase F2: Prompt Builder & Response Processor
-- ============================================================================

-- 1. Create ai_response_templates
create table if not exists public.ai_response_templates (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references public.companies(id) on delete cascade,
  skill text not null check (skill in (
    'team_performance', 'compliance_coach', 'meeting_coach',
    'task_coach', 'member_success', 'knowledge_assistant',
    'leadership_advisor', 'retention_risk', 'growth_opportunity',
    'system_assistant'
  )),
  prompt_version text not null,
  system_prompt text not null check (char_length(trim(system_prompt)) > 0),
  response_schema jsonb not null default '{}'::jsonb,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists ai_response_templates_company_idx
  on public.ai_response_templates (company_id);

create index if not exists ai_response_templates_skill_idx
  on public.ai_response_templates (skill);

-- Updated at trigger
drop trigger if exists set_ai_response_templates_updated_at on public.ai_response_templates;
create trigger set_ai_response_templates_updated_at
  before update on public.ai_response_templates
  for each row execute function public.set_updated_at();

-- RLS
alter table public.ai_response_templates enable row level security;

create policy "Anyone read active templates"
  on public.ai_response_templates for select
  using (is_active = true and (company_id is null or company_id = public.get_user_company_id()));

grant select on public.ai_response_templates to authenticated;

comment on table public.ai_response_templates is 'Stores AI system prompts and JSON schemas per skill. NULL company_id = global template. UUID = company override.';

-- 2. Update ai_context_logs
alter table public.ai_context_logs
  add column if not exists prompt_version text,
  add column if not exists response_schema_version text;

-- 3. Seed Global Templates (f2-v1)
insert into public.ai_response_templates (company_id, skill, prompt_version, system_prompt, response_schema) values
(null, 'team_performance', 'f2-v1', 'You are Ascendra Team Performance Analyst.\n\nObjectives:\n1. Explain team health.\n2. Identify risks.\n3. Identify opportunities.\n4. Recommend actions.\n\nResponse Rules:\n- Use data only.\n- Do not invent members.\n- Explain why.\n- Prioritize actionable insights.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "strengths": { "type": "array", "items": { "type": "string" } },
    "risks": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "strengths", "risks", "recommended_actions", "confidence"]
}'),
(null, 'compliance_coach', 'f2-v1', 'You are Ascendra Compliance Coach.\n\nObjectives:\n1. Review compliance violations.\n2. Determine root causes.\n3. Recommend corrective actions.\n\nResponse Rules:\n- Never recommend automatic termination.\n- Focus on compliance recovery.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "violations": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "escalation_needed": { "type": "boolean" },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "violations", "recommended_actions", "escalation_needed", "confidence"]
}'),
(null, 'meeting_coach', 'f2-v1', 'You are Ascendra Meeting Coach.\n\nObjectives:\n1. Summarize attendance.\n2. Rank engagement.\n3. Identify members needing follow-up.\n\nResponse Rules:\n- Focus on actionable outreach.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "attendance_ranking": { "type": "array", "items": { "type": "string" } },
    "engagement_insights": { "type": "array", "items": { "type": "string" } },
    "follow_ups": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "recommended_actions", "confidence"]
}'),
(null, 'task_coach', 'f2-v1', 'You are Ascendra Task Coach.\n\nObjectives:\n1. Analyze task completion.\n2. Highlight overdue work.\n3. Recommend follow-ups.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "productivity_leaders": { "type": "array", "items": { "type": "string" } },
    "overdue_work": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "recommended_actions", "confidence"]
}'),
(null, 'member_success', 'f2-v1', 'You are Ascendra Member Success Coach.\n\nObjectives:\n1. Assess member status.\n2. Highlight strengths.\n3. Provide an improvement plan.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "strengths": { "type": "array", "items": { "type": "string" } },
    "weaknesses": { "type": "array", "items": { "type": "string" } },
    "improvement_plan": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "recommended_actions", "confidence"]
}'),
(null, 'knowledge_assistant', 'f2-v1', 'You are Ascendra Knowledge Assistant.\n\nObjectives:\n1. Answer questions based on provided documents.\n2. Cite sources.\n\nResponse Rules:\n- Do not hallucinate.\n- Say you do not know if context is insufficient.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "answer": { "type": "string" },
    "sources_cited": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "answer", "recommended_actions", "confidence"]
}'),
(null, 'leadership_advisor', 'f2-v1', 'You are Ascendra Leadership Advisor.\n\nObjectives:\n1. Identify bottlenecks.\n2. Highlight opportunities.\n3. Recommend weekly priorities.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "bottlenecks": { "type": "array", "items": { "type": "string" } },
    "opportunities": { "type": "array", "items": { "type": "string" } },
    "weekly_priorities": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "recommended_actions", "confidence"]
}'),
(null, 'retention_risk', 'f2-v1', 'You are Ascendra Retention Risk Analyzer.\n\nObjectives:\n1. Identify high-risk members.\n2. Analyze risk factors.\n3. Suggest retention actions.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "high_risk_members": { "type": "array", "items": { "type": "string" } },
    "risk_factors": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "high_risk_members", "recommended_actions", "confidence"]
}'),
(null, 'growth_opportunity', 'f2-v1', 'You are Ascendra Growth Opportunity Analyzer.\n\nObjectives:\n1. Identify candidates for promotion.\n2. Recommend expansion steps.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "growth_candidates": { "type": "array", "items": { "type": "string" } },
    "expansion_opportunities": { "type": "array", "items": { "type": "string" } },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "growth_candidates", "recommended_actions", "confidence"]
}'),
(null, 'system_assistant', 'f2-v1', 'You are Ascendra System Assistant.\n\nObjectives:\n1. Guide users on how to use the platform.\n2. Explain feature availability.', '{
  "type": "object",
  "properties": {
    "summary": { "type": "string" },
    "action_steps": { "type": "array", "items": { "type": "string" } },
    "feature_check": { "type": "string" },
    "recommended_actions": { "type": "array", "items": { "type": "string" } },
    "confidence": { "type": "number" }
  },
  "required": ["summary", "recommended_actions", "confidence"]
}');
