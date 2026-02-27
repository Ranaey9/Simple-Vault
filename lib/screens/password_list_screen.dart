import 'package:flutter/material.dart';
import 'add_password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; //Veriyi kalıcı saklamak için
import 'dart:convert';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<Map<String, String>> passwordList = [];

  bool gizliMi = true;
  //Telefon hafızasına veriyi kaydeder
  Future saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("passwords", jsonEncode(passwordList));
  }

  //Telefon hafızasındaki veriyi okur ve ekrana yansıtır
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

  // Sayfa açılır açılmaz hafızadan veriyi okur
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("My Passwords"),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: passwordList.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Center(
                child: Text(
                  "Your saved passwords will appear here.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            )
          : ListView.builder(
              itemCount: passwordList.length,
              itemBuilder: (context, index) {
                final item = passwordList[index];

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.vpn_key,
                      color: Colors.blueAccent,
                    ),

                    title: Text(item['site'] ?? ""),

                    subtitle: Text(
                      gizliMi
                          ? "*" * (item['pass']?.length ?? 0)
                          : item['pass'] ?? "",
                      style: const TextStyle(letterSpacing: 2),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// GÖZ İKONU
                        IconButton(
                          icon: Icon(
                            gizliMi ? Icons.visibility_off : Icons.visibility,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              gizliMi = !gizliMi;
                            });
                          },
                        ),

                        /// SİLME BUTONU
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
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
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, //Klavye açılınca ekran bozulmaz
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
