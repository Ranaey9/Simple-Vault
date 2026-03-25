<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'add_note_screen.dart';
=======
import 'dart:convert';
import 'package:flutter/material.dart';
import 'add_note_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82

class SecretNotesScreen extends StatefulWidget {
  const SecretNotesScreen({super.key});

  @override
  State<SecretNotesScreen> createState() => _SecretNotesScreenState();
}

class _SecretNotesScreenState extends State<SecretNotesScreen> {
  List<Map<String, String>> noteList = [];

<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Secret Notes"),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
      ),
=======
  Future saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("Note List", jsonEncode(noteList));
  }

  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("Note List");

    if (data != null) {
      final List<dynamic> jsonData = jsonDecode(data);

      setState(() {
        noteList = jsonData
            .map((item) => Map<String, String>.from(item))
            .toList();
      });
    }
  }

  void deleteNote(int index) async {
    noteList.removeAt(index);
    await saveData();
    setState(() {});
  }

  Future<bool?> showDeleteDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF8F9FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Delete Note",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Do you want to delete this note?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("No", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      appBar: AppBar(
        title: const Text("Secret Notes"),
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        centerTitle: true,
      ),

>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
      body: noteList.isEmpty
          ? const Center(
              child: Text(
                "No secret notes yet.",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
<<<<<<< HEAD
                return Card(
                  color: const Color(0xFFF5F5F5),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      noteList[index]['title'] ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(noteList[index]['date'] ?? ""),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      _showNoteDetail(context, noteList[index]);
                    },
=======
                return Dismissible(
                  key: Key(noteList[index]['title']! + index.toString()),
                  direction: DismissDirection.horizontal,

                  confirmDismiss: (direction) async {
                    return await showDeleteDialog();
                  },

                  onDismissed: (direction) {
                    deleteNote(index);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Note deleted")),
                    );
                  },

                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  child: Card(
                    color: Color.fromARGB(255, 250, 250, 254),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        noteList[index]['title'] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(noteList[index]['date'] ?? ""),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        _showNoteDetail(context, noteList[index]);
                      },
                    ),
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
                  ),
                );
              },
            ),
<<<<<<< HEAD
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
=======

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005AC1),
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
<<<<<<< HEAD
=======

>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
          if (result != null) {
            setState(() {
              noteList.add(result);
            });
<<<<<<< HEAD
          }
        },
        child: const Icon(Icons.add),
=======

            saveData();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
      ),
    );
  }

  void _showNoteDetail(BuildContext context, Map<String, String> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
<<<<<<< HEAD
=======
        backgroundColor: const Color(0xFFF8F9FF),
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
        title: Text(note['title'] ?? ""),
        content: Text(note['content'] ?? ""),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
<<<<<<< HEAD
            child: const Text("Close"),
=======
            child: const Text("Close",style: TextStyle(color:Color(0xFF005AC1))),
>>>>>>> 456fa3ba3705c8613a12a02bce6eaa82d2492b82
          ),
        ],
      ),
    );
  }
}
