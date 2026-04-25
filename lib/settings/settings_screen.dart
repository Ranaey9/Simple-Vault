import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_vault/l10n/app_localizations.dart';
import 'package:simple_vault/settings/language_screen.dart';

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

    if (!mounted) return;
    setState(() {
      _userName = ('$name $surname').trim().isEmpty ? '' : '$name $surname';
    });
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!context.mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  Future<void> _launchGitHub() async {
    const url = "https://github.com/Ranaey9";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.couldNotLaunchGithub)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings, style: TextStyle(fontSize: screenWidth * 0.05)),
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
                    _userName.isNotEmpty ? _userName[0] : AppLocalizations.of(context)!.user[0],
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
                        _userName.isNotEmpty ? _userName : AppLocalizations.of(context)!.user,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        AppLocalizations.of(context)!.digitalVaultMember,
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
            AppLocalizations.of(context)!.system,
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
                    AppLocalizations.of(context)!.language,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Localizations.localeOf(context).languageCode == 'tr' ? 'Türkçe' : 'English',
                        style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.035),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: screenWidth * 0.04,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/language');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.appVersion,
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
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.privacyPolicy,
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: screenWidth * 0.04,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/privacyPolicy');
                  },
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
                  AppLocalizations.of(context)!.logOut,
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
                  AppLocalizations.of(context)!.designedAndDeveloped,
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
