import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Simple Vault"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),

                const Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: screenHeight * 0.06),

                TextField(
                  controller: isimController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: soyisimController,
                  decoration: InputDecoration(
                    labelText: "Surname",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.07),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      String Name = isimController.text.trim();
                      String Surname = soyisimController.text.trim();
                      //hata mesaji
                      if (Name.isEmpty || Surname.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill in all fields!"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      } else {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setString('userName', Name);
                        await prefs.setString('userSurname', Surname);
                        await prefs.setBool('isLoggedIn', true);

                        print("Hafızaya kaydedildi: $Name $Surname");
                      }
                    },
                    child: Text("Log in", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
