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
              "Quick Codes",
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          ),
          backgroundColor: const Color(0xFFF8F9FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: quickCodes.isEmpty
          ? Center(
              child: Text(
                "Fast code hasn't been added yet.",
                style: TextStyle(fontSize: screenWidth * 0.04),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: quickCodes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: screenWidth * 0.04,
                crossAxisSpacing: screenWidth * 0.04,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = quickCodes[index];
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => _copyToClipboard(item["code"]!),
                      child: Card(
                        color: const Color.fromARGB(255, 250, 250, 254),
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["label"]!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                item["code"]!,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.blueGrey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -5,
                      top: -5,
                      child: GestureDetector(
                        onTap: () => deleteItem(index),
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.015),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: screenWidth * 0.04,
                            color: Colors.white,
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
        child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.07),
      ),
    );
  }
}
