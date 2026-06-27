import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_repository.g.dart';

class SessionRepository {
  final FlutterSecureStorage _storage;
  
  static const _sessionKey = 'supabase_session';

  SessionRepository(this._storage);

  Future<void> saveSession(String sessionString) async {
    await _storage.write(key: _sessionKey, value: sessionString);
  }

  Future<String?> getSession() async {
    return await _storage.read(key: _sessionKey);
  }

  Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
  }
}

@riverpod
SessionRepository sessionRepository(Ref ref) {
  const storage = FlutterSecureStorage();
  return SessionRepository(storage);
}
