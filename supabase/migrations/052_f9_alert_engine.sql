-- ============================================================================
-- 052_f9_alert_engine.sql — Intelligence Automation Data Layer
-- ============================================================================

-- 1. alert_rules
-- Stores automation logic
create table if not exists public.alert_rules (
    id uuid primary key default gen_random_uuid(),
    company_id uuid references public.companies(id) on delete cascade, -- null means global rule
    rule_type text not null, -- e.g. 'High Risk', 'Promotion'
    metric text not null, -- e.g. 'risk_score', 'leadership_score'
    operator text not null, -- e.g. '>', '>=', '<', '=', 'dropped_by'
    threshold numeric not null,
    severity text not null check (severity in ('Critical', 'High', 'Medium', 'Low', 'Informational')),
    enabled boolean default true,
    valid_for_days integer default 30, -- how long until alert expires automatically
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now()
);
create index on public.alert_rules (company_id, enabled);

-- 2. alerts
-- Represents generated intelligence
create table if not exists public.alerts (
    id uuid primary key default gen_random_uuid(),
    company_id uuid not null references public.companies(id) on delete cascade,
    profile_id uuid not null references public.profiles(id) on delete cascade,
    rule_id uuid not null references public.alert_rules(id) on delete cascade,
    
    alert_hash text not null, -- Deterministic deduplication hash: company_id + profile_id + rule_id + period
    
    type text not null,
    severity text not null check (severity in ('Critical', 'High', 'Medium', 'Low', 'Informational')),
    status text not null default 'Unread' check (status in ('Unread', 'Acknowledged', 'Actioned', 'Resolved', 'Expired', 'Archived')),
    
    title text not null,
    description text,
    metadata jsonb default '{}'::jsonb,
    
    created_at timestamp with time zone default now(),
    valid_until timestamp with time zone,
    resolved_at timestamp with time zone,
    
    constraint unique_alert_hash unique (alert_hash)
);
create index on public.alerts (company_id, status);
create index on public.alerts (profile_id, status);

-- 3. alert_deliveries
-- Tracks delivery channels
create table if not exists public.alert_deliveries (
    id uuid primary key default gen_random_uuid(),
    alert_id uuid not null references public.alerts(id) on delete cascade,
    channel text not null check (channel in ('In-App', 'Push', 'Email', 'WhatsApp')),
    status text not null default 'Pending' check (status in ('Pending', 'Delivered', 'Failed')),
    delivered_at timestamp with time zone,
    error_message text,
    created_at timestamp with time zone default now()
);
create index on public.alert_deliveries (alert_id);

-- 4. alert_preferences
-- Each leader configures which alerts they want to receive and how
create table if not exists public.alert_preferences (
    id uuid primary key default gen_random_uuid(),
    profile_id uuid not null references public.profiles(id) on delete cascade,
    alert_type text not null, -- 'High Risk', 'Promotion', etc. or 'All'
    channel text not null check (channel in ('In-App', 'Push', 'Email', 'WhatsApp')),
    enabled boolean default true,
    created_at timestamp with time zone default now(),
    updated_at timestamp with time zone default now(),
    constraint unique_alert_preference unique (profile_id, alert_type, channel)
);

-- 5. automation_logs
-- Audit trail for every automated action
create table if not exists public.automation_logs (
    id uuid primary key default gen_random_uuid(),
    company_id uuid not null references public.companies(id) on delete cascade,
    rule_id uuid references public.alert_rules(id) on delete set null,
    target_profile_id uuid references public.profiles(id) on delete set null,
    trigger_source text not null, -- e.g. 'Decision Engine', 'Manual'
    action_taken text not null, -- e.g. 'Alert Created', 'Escalated'
    result_status text not null check (result_status in ('Success', 'Failed')),
    error_details text,
    created_at timestamp with time zone default now()
);
create index on public.automation_logs (company_id, created_at desc);

-- Add updated_at triggers
create trigger set_alert_rules_updated_at before update on public.alert_rules for each row execute function public.set_updated_at();
create trigger set_alert_preferences_updated_at before update on public.alert_preferences for each row execute function public.set_updated_at();

-- RLS
alter table public.alert_rules enable row level security;
alter table public.alerts enable row level security;
alter table public.alert_deliveries enable row level security;
alter table public.alert_preferences enable row level security;
alter table public.automation_logs enable row level security;

-- Base RLS (System / Leaders)
-- Note: actual RLS would involve matching auth.uid() and role='leader' for the company, keeping simple here for brevity
create policy "Leaders can view company alerts" on public.alerts for select using (company_id = public.get_user_company_id() and exists (select 1 from public.profiles p where p.auth_user_id = auth.uid() and p.role = 'leader'));
create policy "Leaders can update company alerts" on public.alerts for update using (company_id = public.get_user_company_id() and exists (select 1 from public.profiles p where p.auth_user_id = auth.uid() and p.role = 'leader'));

create policy "Users manage own alert preferences" on public.alert_preferences for all using (profile_id in (select id from public.profiles where auth_user_id = auth.uid()));
