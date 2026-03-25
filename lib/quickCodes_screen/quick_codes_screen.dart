import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_quick_code.dart';

class QuickCodesScreen extends StatefulWidget {
  const QuickCodesScreen({super.key});

  @override
  State<QuickCodesScreen> createState() => _QuickCodesScreenState();
}

class _QuickCodesScreenState extends State<QuickCodesScreen> {
  List<Map<String, String>> quickCodes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$text copied!")));
  }

  Future saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("quick_codes", jsonEncode(quickCodes));
  }

  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("quick_codes");
    if (data == null) return;
    quickCodes = List<Map<String, String>>.from(
      jsonDecode(data).map((item) => Map<String, String>.from(item)),
    );
    if (mounted) setState(() {});
  }

  void deleteItem(int index) async {
    quickCodes.removeAt(index);
    await saveData();
    setState(() {});
  }

  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddQuickCode(
          onSave: (label, code) async {
            quickCodes.add({"label": label, "code": code});
            await saveData();
            setState(() {});
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text("Quick Codes"),
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        centerTitle: true,
      ),
      body: quickCodes.isEmpty
          ? const Center(child: Text("Fast code hasn't been added yet."))
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: quickCodes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = quickCodes[index];
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () => _copyToClipboard(item["code"]!),
                      child: Card(
                        color: Color.fromARGB(255, 250, 250, 254),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["label"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item["code"]!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => deleteItem(index),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005AC1),
        onPressed: _openAddSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
