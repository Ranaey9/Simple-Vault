import 'package:flutter/material.dart';

class AddQuickCode extends StatefulWidget {
  final Function(String label, String code) onSave;
  const AddQuickCode({super.key, required this.onSave});

  @override
  State<AddQuickCode> createState() => _AddQuickCodeState();
}

class _AddQuickCodeState extends State<AddQuickCode> {
  final TextEditingController labelController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool _labelFocus = false;
  bool _codeFocus = false;

  final Color primaryColor = const Color(0xFF005AC1);

  void _save() {
    if (labelController.text.trim().isEmpty ||
        codeController.text.trim().isEmpty) {
      return;
    }
    widget.onSave(labelController.text.trim(), codeController.text.trim());
    Navigator.pop(context);
  }

  @override
  void dispose() {
    labelController.dispose();
    codeController.dispose();
    super.dispose();
  }

  InputDecoration _buildDecoration(String label, IconData icon, bool focused) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      labelText: label,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// LABEL
            Focus(
              onFocusChange: (hasFocus) =>
                  setState(() => _labelFocus = hasFocus),
              child: TextField(
                controller: labelController,
                decoration: _buildDecoration("Label", Icons.label, _labelFocus),
              ),
            ),
            const SizedBox(height: 20),

            /// CODE
            Focus(
              onFocusChange: (hasFocus) =>
                  setState(() => _codeFocus = hasFocus),
              child: TextField(
                controller: codeController,
                decoration: _buildDecoration(
                  "Code / Password",
                  Icons.code,
                  _codeFocus,
                ),
              ),
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
                child: const Text("Save", style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
