import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Central repository base class to unify error handling.
abstract class BaseRepository {
  /// Transforms Supabase database and authentication exceptions into clean domain exception messages.
  Never handleException(Object error, [StackTrace? stackTrace]) {
    if (error is supabase.PostgrestException) {
      throw Exception('Database Error: ${error.message} (Code: ${error.code})');
    } else if (error is supabase.AuthException) {
      throw Exception('Authentication Error: ${error.message}');
    } else if (error is ArgumentError) {
      throw Exception('Validation Error: ${error.message}');
    } else {
      throw Exception('Unexpected Error: $error');
    }
  }
}
