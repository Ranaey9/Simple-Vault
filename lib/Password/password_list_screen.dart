import 'package:flutter/material.dart';
import 'add_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<Map<String, String>> passwordList = [];
  bool gizliMi = true;

  Future saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("passwords", jsonEncode(passwordList));
  }

  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("passwords");
    if (data != null) {
      setState(() {
        passwordList = List<Map<String, String>>.from(
          (jsonDecode(data) as List).map(
            (item) => Map<String, String>.from(item),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "My Passwords",
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          ),
          backgroundColor: const Color(0xFFF8F9FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: passwordList.isEmpty
          ? Center(
              child: Text(
                "Your saved passwords will appear here.",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              itemCount: passwordList.length,
              itemBuilder: (context, index) {
                final item = passwordList[index];

                return Card(
                  color: const Color.fromARGB(255, 250, 250, 254),
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.005,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF005AC1).withOpacity(0.1),
                      child: Icon(
                        Icons.vpn_key,
                        color: const Color(0xFF005AC1),
                        size: screenWidth * 0.05,
                      ),
                    ),
                    title: Text(
                      item['site'] ?? "",
                      style: TextStyle(
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      gizliMi
                          ? "*" * (item['pass']?.length ?? 0)
                          : item['pass'] ?? "",
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            gizliMi ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF005AC1),
                            size: screenWidth * 0.055,
                          ),
                          onPressed: () {
                            setState(() {
                              gizliMi = !gizliMi;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                            size: screenWidth * 0.055,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordList.removeAt(index);
                              saveData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005AC1),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddPasswordScreen(
              onSave: (String site, String pass) {
                setState(() {
                  passwordList.add({'site': site, 'pass': pass});
                  saveData();
                });
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.07),
      ),
    );
  }
}
