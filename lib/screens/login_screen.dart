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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    
    final Color primaryColor = const Color(0xFF005AC1);
    final Color surfaceColor = const Color(0xFFF8F9FF);

    return Scaffold(
      backgroundColor: surfaceColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_person_rounded, 
                  size: screenHeight * 0.08, 
                  color: primaryColor
                ),

                SizedBox(height: screenHeight * 0.03),

                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF1A1C1E),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                TextField(
                  controller: isimController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Name",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: 20,
                      color: primaryColor,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 152, 152, 164).withValues(alpha: 0.04),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),

                TextField(
                  controller: soyisimController,
                  decoration: InputDecoration(
                    labelText: "Surname",
                    hintText: "Surname",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(
                      Icons.badge_outlined,
                      size: 18,
                      color: primaryColor,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 152, 152, 164).withValues(alpha: 0.04),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: _handleLogin,
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Log in", 
                      style: TextStyle(fontSize: screenWidth * 0.04)
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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