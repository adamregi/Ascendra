-- ============================================================================
-- 001_extensions.sql — Enable required PostgreSQL extensions
-- ============================================================================
-- Must run FIRST. All other migrations depend on these extensions.
-- Supabase manages the `extensions` schema for extension objects.

create extension if not exists "uuid-ossp" with schema extensions;
create extension if not exists vector with schema extensions;
create extension if not exists ltree with schema extensions;
