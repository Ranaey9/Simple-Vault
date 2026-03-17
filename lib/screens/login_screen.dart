import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_vault/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController isimController = TextEditingController();
  final TextEditingController soyisimController = TextEditingController();

  @override
  void dispose() {
    isimController.dispose();
    soyisimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF005AC1); 
    final Color surfaceColor = const Color(0xFFF8F9FF); 

    return Scaffold(
      backgroundColor: surfaceColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_person_rounded,
                  size: 72,
                  color: primaryColor,
                ),
                
                const SizedBox(height: 24),

                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1C1E),
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: isimController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person_outline, size: 22, color: primaryColor),
                    filled: true,
                    fillColor: primaryColor.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: soyisimController,
                  decoration: InputDecoration(
                    labelText: "Surname",
                    prefixIcon: Icon(Icons.badge_outlined, size: 22, color: primaryColor),
                    filled: true,
                    fillColor: primaryColor.withOpacity(0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: _handleLogin,
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final String name = isimController.text.trim();
    final String surname = soyisimController.text.trim();

    if (name.isEmpty || surname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fields cannot be empty"),
          behavior: SnackBarBehavior.floating,
          elevation: 0, 
          backgroundColor: const Color(0xFFBA1A1A), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name);
      await prefs.setString('userSurname', surname);
      await prefs.setBool('isLoggedIn', true);

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}