import 'package:flutter/material.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key, required Null Function(String site, String pass) onSave});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController siteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: siteController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Site Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: isObscured,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => isObscured = !isObscured),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
