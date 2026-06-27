import 'package:flutter_test/flutter_test.dart';
import 'package:distributor_os/core/failures/failure.dart';

void main() {
  group('Failures', () {
    test('NetworkFailure has correct defaults', () {
      const failure = NetworkFailure();
      expect(failure.code, 'NETWORK_ERROR');
      expect(failure.message, 'No internet connection.');
    });

    test('AuthFailure holds message and code', () {
      const failure = AuthFailure(message: 'Invalid password', code: 'INVALID_CREDENTIALS');
      expect(failure.message, 'Invalid password');
      expect(failure.code, 'INVALID_CREDENTIALS');
    });
  });
}
