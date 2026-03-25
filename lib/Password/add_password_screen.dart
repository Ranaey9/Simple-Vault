import 'package:flutter/material.dart';

class AddPasswordScreen extends StatefulWidget {
  final Function(String site, String pass) onSave;

  const AddPasswordScreen({super.key, required this.onSave});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController siteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool gizliMi = true;
  final Color primaryColor = const Color(0xFF005AC1); // Kullandığın mavi

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
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
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Site Name",
                hintText: "Site Name",
                floatingLabelStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PASSWORD
            TextField(
              controller: passwordController,
              obscureText: gizliMi,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                filled: true,
                fillColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Password",
                hintText: "Site Name",
                floatingLabelStyle: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
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
              onPressed: () {
                if (siteController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  widget.onSave(siteController.text, passwordController.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
