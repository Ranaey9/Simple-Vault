import 'dart:convert';
import 'package:flutter/material.dart';
import 'add_note_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecretNotesScreen extends StatefulWidget {
  const SecretNotesScreen({super.key});

  @override
  State<SecretNotesScreen> createState() => _SecretNotesScreenState();
}

class _SecretNotesScreenState extends State<SecretNotesScreen> {
  List<Map<String, String>> noteList = [];

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF8F9FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Delete Note",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
            ),
          ),
          content: Text(
            "Do you want to delete this note?",
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.04,
                ),
              ),
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
              child: Text(
                "Yes",
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "Secret Notes",
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          ),
          backgroundColor: const Color(0xFFF8F9FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: noteList.isEmpty
          ? Center(
              child: Text(
                "No secret notes yet.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            )
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
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
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: screenWidth * 0.05),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: screenWidth * 0.08,
                    ),
                  ),
                  child: Card(
                    color: const Color.fromARGB(255, 250, 250, 254),
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.005,
                      ),
                      title: Text(
                        noteList[index]['title'] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      subtitle: Text(
                        noteList[index]['date'] ?? "",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: screenWidth * 0.04,
                      ),
                      onTap: () {
                        _showNoteDetail(context, noteList[index]);
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005AC1),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
          if (result != null) {
            setState(() {
              noteList.add(result);
            });
            saveData();
          }
        },
        child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.07),
      ),
    );
  }

  void _showNoteDetail(BuildContext context, Map<String, String> note) {
    final double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF8F9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          note['title'] ?? "",
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            note['content'] ?? "",
            style: TextStyle(fontSize: screenWidth * 0.04),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: TextStyle(
                color: const Color(0xFF005AC1),
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
