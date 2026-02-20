import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(title: const Text("Home Screen"), backgroundColor: const Color(0xFFF5F5F5), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildVaultCard(
              context: context,
              title: "Passwords",
              subtitle: "Securely store your login info",
              icon: Icons.vpn_key_rounded,
              iconColor: Colors.blueAccent,
              onTap: () => print("Passwords Tapped"),
            ),
            buildVaultCard(
              context: context,
              title: "Secret Notes",
              subtitle: "Personal thoughts and logs",
              icon: Icons.notes_rounded,
              iconColor: Colors.orangeAccent,
              onTap: () => print("Notes Tapped"),
            ),
            buildVaultCard(
              context: context,
              title: "Quick Codes",
              subtitle: "Door codes and pins",
              icon: Icons.qr_code_rounded,
              iconColor: Colors.greenAccent,
              onTap: () => print("Codes Tapped"),
            ),
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
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Card(
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
