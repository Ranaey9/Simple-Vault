import 'package:flutter/material.dart';
import 'package:simple_vault/l10n/app_localizations.dart';

class AddQuickCode extends StatefulWidget {
  final Function(String label, String code) onSave;
  const AddQuickCode({super.key, required this.onSave});

  @override
  State<AddQuickCode> createState() => _AddQuickCodeState();
}

class _AddQuickCodeState extends State<AddQuickCode> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final Color primaryColor = const Color(0xFF005AC1);

  @override
  void dispose() {
    labelController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void _save() {
    if (labelController.text.trim().isEmpty || codeController.text.trim().isEmpty) return;
    widget.onSave(labelController.text.trim(), codeController.text.trim());
    Navigator.pop(context);
  }

  InputDecoration _buildDecoration(String label, IconData icon) => InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
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
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: _buildDecoration(l10n.label, Icons.label),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              decoration: _buildDecoration(l10n.codeOrPassword, Icons.code),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(l10n.save, style: const TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
