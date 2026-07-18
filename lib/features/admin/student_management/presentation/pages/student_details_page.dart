import 'package:flutter/material.dart';

import '../../data/models/student_model.dart';

class StudentDetailsPage extends StatelessWidget {
  final StudentModel student;

  const StudentDetailsPage({
    super.key,
    required this.student,
  });

  Widget buildTile(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 0,

      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Student Profile"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Center(
            child: CircleAvatar(
              radius: 45,
              child: Text(
                student.fullName[0],
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Center(
            child: Text(
              student.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          buildTile(
            "Registration No",
            student.registrationNo,
            Icons.badge,
          ),

          buildTile(
            "Email",
            student.email,
            Icons.email,
          ),

          buildTile(
            "Department",
            student.department,
            Icons.school,
          ),

          buildTile(
            "Semester",
            student.semester,
            Icons.menu_book,
          ),

          buildTile(
            "Section",
            student.section,
            Icons.groups,
          ),

          buildTile(
            "Status",
            student.status.name.toUpperCase(),
            Icons.verified_user,
          ),
        ],
      ),
    );
  }
}