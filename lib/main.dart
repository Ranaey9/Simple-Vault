import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_vault/Password/password_list_screen.dart';
import 'package:simple_vault/notes_screen/secret_notes_screen.dart';
import 'package:simple_vault/quickCodes_screen/quick_codes_screen.dart';
import 'package:simple_vault/screens/home_screen.dart';
import 'package:simple_vault/screens/login_screen.dart';
import 'package:simple_vault/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/passwords': (context) => PasswordListScreen(),
        '/SecretNotes': (context) => const SecretNotesScreen(),
        '/quickCodes': (context) => const QuickCodesScreen(),
      },
    );
  }
}