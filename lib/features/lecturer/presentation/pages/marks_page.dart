import 'package:flutter/material.dart';

class MarksPage extends StatelessWidget {
  const MarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Marks"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Upload Marks\n(Coming in Phase 2 - Part 9)",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}