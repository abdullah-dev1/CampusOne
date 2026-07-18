import 'package:flutter/material.dart';

class GradesHeader extends StatelessWidget {
  const GradesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Grade Management",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Manage quizzes, mids, finals and lab marks.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

        ],
      ),
    );
  }
}