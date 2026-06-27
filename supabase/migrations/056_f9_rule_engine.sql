-- ============================================================================
-- 056_f9_rule_engine.sql — Configurable Rule Engine Data
-- ============================================================================

-- Seed the initial Global rules for Intelligence Automation
insert into public.alert_rules (company_id, rule_type, metric, operator, threshold, severity, valid_for_days)
values
  -- High Risk Rule
  (null, 'High Risk', 'risk_score', '>', 85, 'Critical', 7),
  
  -- Promotion Rule
  (null, 'Promotion', 'leadership_score', '>=', 90, 'High', 30),
  
  -- Growth Rule
  (null, 'Growth Highlight', 'attendance_growth', '>=', 25, 'Low', 14),
  
  -- Recognition Rule
  (null, 'Recognition', 'recognition_gap_days', '>', 14, 'Medium', 14),
  
  -- Retention Rule
  (null, 'Retention Warning', 'health_drop', '>=', 15, 'Critical', 7)
on conflict do nothing;
