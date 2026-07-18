import 'package:flutter/material.dart';
import '../../data/models/student_model.dart';

class ProfileHeader extends StatelessWidget {
  final StudentModel student;

  const ProfileHeader({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.blue.shade100,
          child: Text(
            student.fullName[0],
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 14),

        Text(
          student.fullName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 6),

        Text(student.registrationNo),

      ],
    );
  }
}