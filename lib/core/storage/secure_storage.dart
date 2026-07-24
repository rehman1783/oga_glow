import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper around flutter_secure_storage for auth token persistence.
class SecureStorage {
  final FlutterSecureStorage _storage;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  SecureStorage()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  // ------------------------------------------------------------------
  // Token
  // ------------------------------------------------------------------

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ------------------------------------------------------------------
  // User data (stored as JSON string)
  // ------------------------------------------------------------------

  Future<void> saveUser(String userJson) async {
    await _storage.write(key: _userKey, value: userJson);
  }

  Future<String?> getUser() async {
    return _storage.read(key: _userKey);
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: _userKey);
  }

  // ------------------------------------------------------------------
  // Clear all auth data
  // ------------------------------------------------------------------

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

