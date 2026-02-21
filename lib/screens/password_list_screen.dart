import 'package:flutter/material.dart';
import 'package:simple_vault/screens/add_password_screen.dart';

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
            isScrollControlled: true, // Klavyenin formu yukarı itmesi için şart
            builder: (BuildContext context) {
              // Pencere içindeki state'i yönetmek için StatefulBuilder kullanıyoruz
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
                        // 1. Kutu: Site Adı (SiteController'ı buraya bağla)
                        TextField(
                          decoration: InputDecoration(labelText: "Site Name"),
                        ),

                        const SizedBox(height: 15),

                        // 2. Kutu: Şifre (Özel Göz İkonlu Kutu)
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
                                // DİKKAT: setModalState kullanarak pencereyi yeniliyoruz
                                setModalState(() {
                                  isObscured = !isObscured;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 3. Buton: Kaydet Butonu
                        ElevatedButton(
                          onPressed: () {
                            // Buraya listeye ekleme kodunu yazacağız
                            Navigator.pop(context); // Pencereyi kapat
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
