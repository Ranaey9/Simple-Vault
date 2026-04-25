import 'package:flutter/material.dart';
import 'add_note_screen.dart';
import 'package:simple_vault/services/secure_storage_service.dart';
import 'package:simple_vault/l10n/app_localizations.dart';

class SecretNotesScreen extends StatefulWidget {
  const SecretNotesScreen({super.key});

  @override
  State<SecretNotesScreen> createState() => _SecretNotesScreenState();
}

class _SecretNotesScreenState extends State<SecretNotesScreen> {
  List<Map<String, String>> noteList = [];

  Future<void> saveData() async => SecureStorageService.saveNotes(noteList);

  Future<void> loadData() async {
    final data = await SecureStorageService.loadNotes();
    setState(() => noteList = data);
  }

  void deleteNote(int index) async {
    noteList.removeAt(index);
    await saveData();
    setState(() {});
  }

  Future<bool?> showDeleteDialog() {
    final l10n = AppLocalizations.of(context)!;
    final double sw = MediaQuery.of(context).size.width;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF8F9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.deleteNote, style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.05)),
        content: Text(l10n.deleteNoteConfirm, style: TextStyle(fontSize: sw * 0.04)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.no, style: TextStyle(color: Colors.grey, fontSize: sw * 0.04)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(l10n.yes, style: TextStyle(fontSize: sw * 0.04)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final double sh = MediaQuery.of(context).size.height;
    final double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(l10n.secretNotes, style: TextStyle(fontSize: sw * 0.05)),
          ),
          backgroundColor: const Color(0xFFF8F9FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: noteList.isEmpty
          ? Center(
              child: Text(
                l10n.noNotesYet,
                style: TextStyle(color: Colors.grey, fontSize: sw * 0.045),
              ),
            )
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(noteList[index]['title']! + index.toString()),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (d) async => await showDeleteDialog(),
                  onDismissed: (d) {
                    deleteNote(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.noteDeleted)),
                    );
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: sw * 0.05),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white, size: sw * 0.08),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: sw * 0.05),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white, size: sw * 0.08),
                  ),
                  child: Card(
                    color: const Color.fromARGB(255, 250, 250, 254),
                    margin: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.01),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.005),
                      title: Text(
                        noteList[index]['title'] ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: sw * 0.045),
                      ),
                      subtitle: Text(noteList[index]['date'] ?? "", style: TextStyle(fontSize: sw * 0.035)),
                      trailing: Icon(Icons.arrow_forward_ios, size: sw * 0.04),
                      onTap: () => _showNoteDetail(context, noteList[index]),
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
            setState(() => noteList.add(result));
            saveData();
          }
        },
        child: Icon(Icons.add, color: Colors.white, size: sw * 0.07),
      ),
    );
  }

  void _showNoteDetail(BuildContext context, Map<String, String> note) {
    final double sw = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF8F9FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(note['title'] ?? "", style: TextStyle(fontSize: sw * 0.05, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(child: Text(note['content'] ?? "", style: TextStyle(fontSize: sw * 0.04))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close, style: TextStyle(color: const Color(0xFF005AC1), fontSize: sw * 0.04)),
          ),
        ],
      ),
    );
  }
}
