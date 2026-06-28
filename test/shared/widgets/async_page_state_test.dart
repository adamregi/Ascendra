import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/shared/state/app_async_state.dart';
import 'package:distributor_os/shared/widgets/async_page_state.dart';

void main() {
  group('AsyncPageState', () {
    testWidgets('renders loading state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AsyncPageState<String>(
            state: const AppAsyncState.loading(),
            loading: () => const Text('Loading...'),
            error: (err, st) => const Text('Error'),
            empty: () => const Text('Empty'),
            builder: (data) => Text('Data: $data'),
          ),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('renders success state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AsyncPageState<String>(
            state: const AppAsyncState.success('Test Data'),
            loading: () => const Text('Loading...'),
            error: (err, st) => const Text('Error'),
            empty: () => const Text('Empty'),
            builder: (data) => Text('Data: $data'),
          ),
        ),
      );

      expect(find.text('Data: Test Data'), findsOneWidget);
    });

    testWidgets('renders error state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AsyncPageState<String>(
            state: const AppAsyncState.error('Failed to load'),
            loading: () => const Text('Loading...'),
            error: (err, st) => Text('Error: $err'),
            empty: () => const Text('Empty'),
            builder: (data) => Text('Data: $data'),
          ),
        ),
      );

      expect(find.text('Error: Failed to load'), findsOneWidget);
    });

    testWidgets('renders empty state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AsyncPageState<String>(
            state: const AppAsyncState.empty(),
            loading: () => const Text('Loading...'),
            error: (err, st) => const Text('Error'),
            empty: () => const Text('No data found'),
            builder: (data) => Text('Data: $data'),
          ),
        ),
      );

      expect(find.text('No data found'), findsOneWidget);
    });
  });
}
