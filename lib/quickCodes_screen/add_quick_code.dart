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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: labelController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.label),
              filled: true,
              fillColor: Colors.white,
              labelText: "Label",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.code),
              filled: true,
              fillColor: Colors.white,
              labelText: "Code / Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
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
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}
