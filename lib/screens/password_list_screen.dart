import 'package:flutter/material.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<Map<String, String>> passwordList = [];
  TextEditingController passController = TextEditingController();
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("My Passwords"),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "Your saved passwords will appear here.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(
                        context,
                      ).viewInsets.bottom, // Klavye boşluğu
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Sadece içerik kadar yer kapla
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: "Site Name"),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          obscureText: isObscured, // Şifreyi gizle/göster
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                //pencereyi yeniliyoruz
                                setModalState(() {
                                  isObscured = !isObscured;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Save Password"),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
