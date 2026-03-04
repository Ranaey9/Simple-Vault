
import 'package:flutter/material.dart';

class QuickCodesScreen extends StatefulWidget {
  const QuickCodesScreen({super.key});

  @override
  State<QuickCodesScreen> createState() => _QuickCodesScreenState();
}

class _QuickCodesScreenState extends State<QuickCodesScreen> {
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
      body: const Center(
        child: Text(
          "No quick codes yet.",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}