import 'package:flutter/material.dart';

class NoticeHeader extends StatelessWidget {
  const NoticeHeader({super.key});

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
            "Notice Board",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Latest announcements for students and lecturers.",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

        ],
      ),
    );
  }
}