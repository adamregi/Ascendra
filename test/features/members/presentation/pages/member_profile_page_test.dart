import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/features/members/presentation/pages/member_profile_page.dart';
import 'package:distributor_os/core/types/result.dart';
import 'package:distributor_os/core/failures/failure.dart';
import 'package:distributor_os/features/members/presentation/providers/member_providers.dart';

void main() {
  testWidgets('MemberProfilePage renders loading then error if missing', (
    WidgetTester tester,
  ) async {
    // Override provider to return error
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fetchMemberProfileProvider('123').overrideWith(
            (ref) => Future.value(Error(UnknownFailure(message: 'Not Found'))),
          ),
        ],
        child: const MaterialApp(home: MemberProfilePage(memberId: '123')),
      ),
    );

    // Initial loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    // After loading, it should show error
    expect(find.text('Not Found'), findsOneWidget);
  });
}
