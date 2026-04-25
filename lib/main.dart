import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_vault/Password/password_list_screen.dart';
import 'package:simple_vault/l10n/app_localizations.dart';
import 'package:simple_vault/notes_screen/secret_notes_screen.dart';
import 'package:simple_vault/quickCodes_screen/quick_codes_screen.dart';
import 'package:simple_vault/screens/home_screen.dart';
import 'package:simple_vault/screens/login_screen.dart';
import 'package:simple_vault/settings/settings_screen.dart';
import 'package:simple_vault/settings/privacy_policy_screen.dart';
import 'package:simple_vault/settings/language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String langCode = prefs.getString('language_code') ?? 'en';
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn, initialLocale: Locale(langCode)));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final Locale initialLocale;
  const MyApp({super.key, required this.isLoggedIn, required this.initialLocale});

  @override
  State<MyApp> createState() => _MyAppState();

  // Dili her yerden değiştirebilmek için bir yardımcı metod
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      home: widget.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/passwords': (context) => const PasswordListScreen(),
        '/SecretNotes': (context) => const SecretNotesScreen(),
        '/quickCodes': (context) => const QuickCodesScreen(),
        '/privacyPolicy': (context) => const PrivacyPolicyScreen(),
        '/language': (context) => const LanguageScreen(),
      },
    );
  }
}