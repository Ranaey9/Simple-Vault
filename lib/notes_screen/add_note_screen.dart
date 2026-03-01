import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
         backgroundColor: const Color(0xFFF5F5F5),
        title: const Text("New Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
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
            const Divider(), // Araya ince bir çizgi
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null, // Yazdıkça aşağı iner
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

  void _saveNote() {
    Color:Colors.white;
    if (titleController.text.isNotEmpty) {
      String formattedDate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}";
      // Verileri paketleyip bir önceki sayfaya geri gönderiyoruz
      Navigator.pop(context, {
        'title': titleController.text,
        'content': contentController.text,
        'date': formattedDate,
      });
    }
  }
}