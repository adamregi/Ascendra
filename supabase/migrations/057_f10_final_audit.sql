-- ============================================================================
-- 057_f10_final_audit.sql — Backend Telemetry & Observability
-- ============================================================================

-- 1. Cron Execution Logs
create table if not exists public.cron_execution_logs (
    id uuid primary key default gen_random_uuid(),
    job_name text not null,
    started_at timestamp with time zone default now(),
    completed_at timestamp with time zone,
    status text not null check (status in ('Running', 'Success', 'Failed')),
    duration_ms integer,
    records_processed integer,
    error_details text,
    created_at timestamp with time zone default now()
);
create index on public.cron_execution_logs (job_name, created_at desc);
create index on public.cron_execution_logs (status);

-- 2. Edge Function Logs
create table if not exists public.edge_function_logs (
    id uuid primary key default gen_random_uuid(),
    function_name text not null,
    invoked_by uuid references public.profiles(id) on delete set null,
    company_id uuid references public.companies(id) on delete cascade,
    execution_id text, -- Provider specific execution trace
    started_at timestamp with time zone default now(),
    completed_at timestamp with time zone,
    status text not null check (status in ('Running', 'Success', 'Failed')),
    duration_ms integer,
    error_details text,
    metadata jsonb default '{}'::jsonb,
    created_at timestamp with time zone default now()
);
create index on public.edge_function_logs (function_name, created_at desc);
create index on public.edge_function_logs (company_id, created_at desc);

-- RLS
alter table public.cron_execution_logs enable row level security;
alter table public.edge_function_logs enable row level security;

-- System-level logs are only readable by admins. We leave them restricted for now.
create policy "Admins can read cron logs" on public.cron_execution_logs for select using (
    exists (select 1 from public.profiles where auth_user_id = auth.uid() and role = 'admin')
);
create policy "Admins can read edge logs" on public.edge_function_logs for select using (
    exists (select 1 from public.profiles where auth_user_id = auth.uid() and role = 'admin')
);

-- Add duration calculation helper
create or replace function public.calculate_duration_ms(p_start timestamp with time zone, p_end timestamp with time zone)
returns integer
language plpgsql
immutable
as $$
begin
    return extract(epoch from (p_end - p_start)) * 1000;
end;
$$;
