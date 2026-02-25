import 'package:flutter/material.dart';
import 'add_password_screen.dart';

class PasswordListScreen extends StatefulWidget {
  //çünkü kullanıcı ekleme ve silme işlemleri yapacağımız için StatefulWidget kullanıyoruz
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<Map<String, String>> passwordList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("My Passwords"),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
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
                      "********",
                      style: const TextStyle(letterSpacing: 2),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          passwordList.removeAt(index);
                        });
                      },
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
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddPasswordScreen(
              onSave: (String site, String pass) {
                setState(() {
                  passwordList.add({'site': site, 'pass': pass});
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
