import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/features/members/presentation/pages/member_directory_page.dart';
import 'package:distributor_os/shared/widgets/search_widgets.dart';
import 'package:distributor_os/shared/widgets/paged_list_view.dart';
import 'package:distributor_os/core/types/result.dart';
import 'package:distributor_os/features/members/presentation/providers/member_providers.dart';
import 'package:distributor_os/features/members/domain/entities/member_directory_item.dart';

void main() {
  testWidgets('MemberDirectoryPage renders correctly', (
    WidgetTester tester,
  ) async {
    // Override provider to return empty directory
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fetchMemberDirectoryProvider.overrideWith(
            (ref) => Future.value(Success(<MemberDirectoryItem>[])),
          ),
        ],
        child: const MaterialApp(home: MemberDirectoryPage()),
      ),
    );

    // Initial loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    // After loading, it should show the page with empty state
    expect(find.text('Network Directory'), findsOneWidget);
    expect(find.byType(SearchBarWidget), findsOneWidget);
    expect(find.byType(FilterChipGroup<String>), findsOneWidget);
    expect(find.text('No members found'), findsOneWidget);
  });
}
