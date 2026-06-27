import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:distributor_os/main.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: DistributorOS()));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}