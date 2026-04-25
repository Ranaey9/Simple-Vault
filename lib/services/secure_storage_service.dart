import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _passwordsKey = 'secure_passwords';

  static Future<List<Map<String, String>>> loadPasswords() async {
    final data = await _storage.read(key: _passwordsKey);
    if (data == null) return [];
    return List<Map<String, String>>.from(
      (jsonDecode(data) as List).map((item) => Map<String, String>.from(item)),
    );
  }

  static Future<void> savePasswords(List<Map<String, String>> passwords) async {
    await _storage.write(key: _passwordsKey, value: jsonEncode(passwords));
  }

  static const _notesKey = 'secure_notes';

  static Future<List<Map<String, String>>> loadNotes() async {
    final data = await _storage.read(key: _notesKey);
    if (data == null) return [];
    return List<Map<String, String>>.from(
      (jsonDecode(data) as List).map((item) => Map<String, String>.from(item)),
    );
  }

  static Future<void> saveNotes(List<Map<String, String>> notes) async {
    await _storage.write(key: _notesKey, value: jsonEncode(notes));
  }

  static const _quickCodesKey = 'secure_quick_codes';

  static Future<List<Map<String, String>>> loadQuickCodes() async {
    final data = await _storage.read(key: _quickCodesKey);
    if (data == null) return [];
    return List<Map<String, String>>.from(
      (jsonDecode(data) as List).map((item) => Map<String, String>.from(item)),
    );
  }

  static Future<void> saveQuickCodes(
    List<Map<String, String>> quickCodes,
  ) async {
    await _storage.write(key: _quickCodesKey, value: jsonEncode(quickCodes));
  }

  static const _pinKey = 'secure_pin';

  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  static Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  static Future<bool> hasPin() async {
    final pin = await _storage.read(key: _pinKey);
    return pin != null && pin.isNotEmpty;
  }
}
