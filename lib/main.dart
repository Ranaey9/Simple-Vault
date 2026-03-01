import 'package:flutter/material.dart';
import 'package:simple_vault/Password/password_list_screen.dart';
import 'package:simple_vault/notes_screen/secret_notes_screen.dart';
import 'package:simple_vault/screens/home_screen.dart';
import 'package:simple_vault/screens/login_screen.dart';
import 'package:simple_vault/settings/settings_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/login',
  routes: {
    '/home': (context) => const HomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/settings': (context) => const SettingsScreen(),
    '/passwords': (context) => PasswordListScreen(),
    '/SecretNotes': (context) => const SecretNotesScreen(),
  },
);
  }
}
