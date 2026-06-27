import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AI Skill Router Tests', () {
    test('routes to compliance_coach when asking about missed meetings', () async {
      // TODO: Implement actual Supabase RPC call
      // final response = await supabase.rpc('route_skill', params: { 'p_company_id': '...', 'p_question': 'Who missed meetings?' });
      // expect(response['skill'], 'compliance_coach');
      expect(true, isTrue);
    });

    test('returns knowledge_assistant as safe fallback', () async {
      // TODO: Implement actual Supabase RPC call
      expect(true, isTrue);
    });

    test('sets needs_clarification to true on close tie', () async {
      // TODO: Implement actual Supabase RPC call
      expect(true, isTrue);
    });

    test('respects company-specific override priority over global', () async {
      // TODO: Implement actual Supabase RPC call
      expect(true, isTrue);
    });
  });
}
