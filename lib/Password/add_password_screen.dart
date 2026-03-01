import 'package:flutter/material.dart';

class AddPasswordScreen extends StatefulWidget {
  final Function(String site, String pass) onSave;

  const AddPasswordScreen({
    super.key,
    required this.onSave,
  }); // onSave fonksiyonu, site ve pass parametrelerini alır ve geri döndürür. Bu, kullanıcı yeni bir şifre eklediğinde, bu bilgiyi PasswordListScreen'e iletmek için kullanılır.

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController siteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool gizliMi = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// SITE
          TextField(
            controller: siteController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.language),
              filled: true,
              fillColor: Colors.white,
              labelText: "Site Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// PASSWORD
          TextField(
            controller: passwordController,
            obscureText: gizliMi,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.visibility),
              filled: true,
              fillColor: Colors.white,
              labelText: "Password",

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              suffixIcon: IconButton(
                icon: Icon(gizliMi ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    gizliMi = !gizliMi;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            //boş değilse kaydet
            onPressed: () {
              if (siteController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                widget.onSave(siteController.text, passwordController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
