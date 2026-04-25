import 'package:flutter/material.dart';
import 'package:simple_vault/l10n/app_localizations.dart';

class AddPasswordScreen extends StatefulWidget {
  final Function(String site, String pass) onSave;
  const AddPasswordScreen({super.key, required this.onSave});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController siteController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidden = true;
  final Color primaryColor = const Color(0xFF005AC1);

  InputDecoration _fieldDecor(String label) => InputDecoration(
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: label,
        hintText: label,
        floatingLabelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        top: 20, left: 20, right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Site adı alanı
            TextField(
              controller: siteController,
              decoration: _fieldDecor(l10n.siteName).copyWith(
                prefixIcon: const Icon(Icons.language),
              ),
            ),
            const SizedBox(height: 20),
            // Şifre alanı (göster/gizle butonu ile)
            TextField(
              controller: passwordController,
              obscureText: _hidden,
              decoration: _fieldDecor(l10n.password).copyWith(
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _hidden = !_hidden),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (siteController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  widget.onSave(siteController.text, passwordController.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
