import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:distributor_os/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App starts and shows Splash then Login', (
    WidgetTester tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify we landed on Login Page due to no active session
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });
}
