SET ROLE authenticated;
SELECT set_config('request.jwt.claims', '{"sub": "baaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"}', true);
SELECT count(*) FROM public.get_executive_overview();

SELECT set_config('request.jwt.claims', '{"sub": "bc52f3a9-4f79-4508-b50d-26b5d2aeb691"}', true);
SELECT count(*) FROM public.get_executive_overview();
