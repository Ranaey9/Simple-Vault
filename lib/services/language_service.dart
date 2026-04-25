import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static final ValueNotifier<String> languageCode = ValueNotifier<String>('en');

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    languageCode.value = prefs.getString('language_code') ?? 'en';
  }

  static Future<void> setLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
    languageCode.value = code;
  }

  static String get(String en, String tr) {
    return languageCode.value == 'tr' ? tr : en;
  }
}
