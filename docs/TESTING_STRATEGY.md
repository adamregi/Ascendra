# Testing Strategy — Ascendra

> **Purpose**: The testing pyramid and conventions for Ascendra.

---

## 1. Unit Tests

**Target**: Domain logic, ViewModels (Freezed `fromJson` parsing), and complex Riverpod Notifiers.
**Location**: `test/features/<feature_name>/...`

Because Ascendra relies on the backend for most business logic, Flutter unit tests are primarily focused on ensuring that:
1. JSON is parsed correctly into Freezed models.
2. State transitions in Notifiers happen as expected.

### Mocking
Use `mockito` to mock Repositories when testing Providers.

```dart
@GenerateNiceMocks([MockSpec<AuthRepository>()])
import 'auth_provider_test.mocks.dart';

void main() {
  test('login success updates state', () async {
    final mockRepo = MockAuthRepository();
    when(mockRepo.login(any, any)).thenAnswer((_) async => true);
    
    // Test Provider
  });
}
```

## 2. Widget Tests

**Target**: Reusable components in `lib/shared/widgets/` and complex feature-specific widgets.
**Location**: `test/shared/widgets/...`

Widget tests should verify that:
1. The widget renders without throwing errors.
2. The widget displays the correct data given a specific ViewModel.
3. Interactions (taps, text input) trigger the expected callbacks.

```dart
testWidgets('AppButton shows loading indicator', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: AppButton(isLoading: true, onPressed: (){}, text: 'Submit'))),
  );
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  expect(find.text('Submit'), findsNothing);
});
```

## 3. Golden Tests (Visual Regression)

For critical UI components, we use Golden Tests to ensure pixel-perfect rendering across changes.

Run golden tests with:
`flutter test --update-goldens`

## 4. Integration Tests

**Target**: End-to-end user flows (e.g., Login -> Dashboard -> View Task -> Submit Proof).
**Location**: `integration_test/`

Integration tests run on real devices or emulators and communicate with the local Supabase emulator instance.

To run:
`flutter test integration_test/login_flow_test.dart`

## 5. Database Testing (pgTAP)

Because a massive amount of business logic lives in PostgreSQL RPCs and Triggers, testing the database is critical.

Ascendra uses `pgTAP` for database testing within the Supabase emulator.

**Location**: `supabase/tests/`

To run database tests:
`supabase test db`
