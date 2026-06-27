import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:distributor_os/features/dashboard/presentation/widgets/executive_overview_card.dart';
import 'package:distributor_os/features/dashboard/data/models/executive_overview_model.dart';
import 'package:distributor_os/shared/widgets/error_widgets.dart';

void main() {
  testWidgets('ExecutiveOverviewCard shows ErrorCard on error and calls onRetry', (WidgetTester tester) async {
    bool retryCalled = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExecutiveOverviewCard(
            data: AsyncValue.error(Exception('Failed API'), StackTrace.empty),
            onRetry: () {
              retryCalled = true;
            },
          ),
        ),
      ),
    );

    // Verify ErrorCard is shown
    expect(find.byType(ErrorCard), findsOneWidget);
    expect(find.text('Failed to load executive overview'), findsOneWidget);

    // Tap retry button
    final retryButton = find.text('Retry');
    expect(retryButton, findsOneWidget);
    
    await tester.tap(retryButton);
    await tester.pump();
    
    expect(retryCalled, isTrue);
  });
  
  testWidgets('ExecutiveOverviewCard shows large numbers correctly', (WidgetTester tester) async {
    final mockData = ExecutiveOverviewModel(
      generatedAt: DateTime.now(),
      health: const OverviewHealth(
        teamHealthScore: 88.0,
        teamSize: 12456, // Large number test
        activeMembers: 11000,
        attendanceRate: 98.5,
        completionRate: 95.0,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExecutiveOverviewCard(
            data: AsyncValue.data(mockData),
          ),
        ),
      ),
    );

    expect(find.text('12456'), findsOneWidget);
    expect(find.text('TEAM SIZE'), findsOneWidget);
  });
}
