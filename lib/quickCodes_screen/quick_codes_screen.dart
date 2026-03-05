import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickCodesScreen extends StatefulWidget {
  const QuickCodesScreen({super.key});

  @override
  State<QuickCodesScreen> createState() => _QuickCodesScreenState();
}

class _QuickCodesScreenState extends State<QuickCodesScreen> {
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$text kopyalandı!")));
  }

  List<Map<String, String>> quickCodes = [];
  TextEditingController labelController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Quick Codes"),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
      ),
      body: quickCodes.isEmpty
          ? const Center(child: Text("Henüz hızlı kod eklenmedi"))
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemCount: quickCodes.length,
              itemBuilder: (context, index) {
                final item = quickCodes[index];
                return GestureDetector(
                  onTap: () => _copyToClipboard(item['code']!),
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.pin, color: Colors.green, size: 30),
                        const SizedBox(height: 10),
                        Text(
                          item['label']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['code']!,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => _showAddCodeSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddCodeSheet(BuildContext context) {}
}
