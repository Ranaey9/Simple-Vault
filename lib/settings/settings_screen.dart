import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _userName = "User";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('userName') ?? "";
    String surname = prefs.getString('userSurname') ?? "";

    setState(() {
      _userName = (name + " " + surname).trim().isEmpty
          ? "User"
          : "$name $surname";
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<void> _launchGitHub() async {
    const url = "https://github.com/Ranaey9";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Could not launch GitHub")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontSize: screenWidth * 0.05)),
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.045),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.09,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    _userName.isNotEmpty ? _userName[0] : "?",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Digital Vault Member",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.035),

          Text(
            "SYSTEM",
            style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03),
          ),
          SizedBox(height: screenHeight * 0.01),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "App Version",
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  trailing: Text(
                    "1.0",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Center(
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              onTap: () => _logout(context),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          Center(
            child: Column(
              children: [
                Text(
                  "Designed & Developed by You",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.032,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                GestureDetector(
                  onTap: _launchGitHub,
                  child: Text(
                    "github.com/Ranaey9",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: screenWidth * 0.032,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
