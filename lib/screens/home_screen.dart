import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_vault/Password/password_list_screen.dart';
import 'package:simple_vault/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Sayfa açılır açılmaz hafızadan ismi okuyor
  }

  String name = "";
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('userName') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        automaticallyImplyLeading: true,

        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 72, 69, 69),
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Hello, $name! ",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            buildVaultCard(
              context: context,
              title: "Passwords",
              subtitle: "Securely store your login info",
              icon: Icons.vpn_key_rounded,
              iconColor: const Color.fromARGB(255, 76, 130, 222),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordListScreen(),
                  ),
                );
              },
            ),
            buildVaultCard(
              context: context,
              title: "Secret Notes",
              subtitle: "Personal thoughts and logs",
              icon: Icons.notes_rounded,
              iconColor: const Color.fromARGB(255, 241, 162, 59),
              onTap: () => print("Notes Tapped"),
            ),
            buildVaultCard(
              context: context,
              title: "Quick Codes",
              subtitle: "Door codes and pins",
              icon: Icons.qr_code_rounded,
              iconColor: const Color.fromARGB(255, 81, 187, 136),
              onTap: () => print("Codes Tapped"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildVaultCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    Color backgroundColor = Colors.white,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
      color: const Color.fromARGB(255, 244, 241, 241),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        //InkWell kullanarak tüm kartı tıklanabilir yapıyoruz
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: screenHeight * 0.15,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                radius: 30,
                child: Icon(icon, color: iconColor, size: 30),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
