import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/shared/widgets/metric_card.dart';

void main() {
  testWidgets('MetricCard renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MetricCard(
            title: 'Total Users',
            value: '1,234',
            icon: Icon(Icons.people),
          ),
        ),
      ),
    );

    expect(find.text('Total Users'), findsOneWidget);
    expect(find.text('1,234'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });
}
