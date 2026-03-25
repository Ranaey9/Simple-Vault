import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _saveNote() {
    if (titleController.text.isNotEmpty) {
      String formattedDate =
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} "
          "${DateTime.now().hour}:${DateTime.now().minute}";

      Navigator.pop(context, {
        'title': titleController.text,
        'content': contentController.text,
        'date': formattedDate,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFFF8F9FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FF),
        title: const Text("New Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Color(0xFF005AC1), size: 30),
            onPressed: _saveNote,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),

            const Divider(),

            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Start writing...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
