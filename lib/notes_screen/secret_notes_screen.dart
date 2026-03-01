import 'package:flutter/material.dart';
import 'add_note_screen.dart';

class SecretNotesScreen extends StatefulWidget {
  const SecretNotesScreen({super.key});

  @override
  State<SecretNotesScreen> createState() => _SecretNotesScreenState();
}

class _SecretNotesScreenState extends State<SecretNotesScreen> {
  // Notları sakladığımız liste (Başlık, İçerik ve Tarih tutuyor)
  List<Map<String, String>> noteList = [];

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
      body: noteList.isEmpty
          ? const Center(child: Text("No secret notes yet.", style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                return Card(
                  color:const Color(0xFFF5F5F5),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(noteList[index]['title'] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(noteList[index]['date'] ?? ""), // Altında tarih yazar
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18), // İstediğin > işareti
                    onTap: () {
                      // Buraya tıklandığında notun içeriğini gösteren bir popup veya sayfa yapabiliriz
                      _showNoteDetail(context, noteList[index]);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () async {
          // Navigasyon ile yeni sayfaya gidiyoruz ve oradan gelen veriyi bekliyoruz
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );

          // Eğer yeni bir not kaydedilip dönüldüyse listeye ekle
          if (result != null) {
            setState(() {
              noteList.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Not detayını görmek için basit bir pencere
  void _showNoteDetail(BuildContext context, Map<String, String> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F5),
        title: Text(note['title'] ?? ""),
        content: Text(note['content'] ?? ""),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }
}