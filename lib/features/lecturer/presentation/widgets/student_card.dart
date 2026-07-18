import 'package:flutter/material.dart';

import '../../../admin/student_management/data/models/student_model.dart';
import '../pages/student_details_page.dart';

class StudentCard extends StatelessWidget {
  final StudentModel student;

  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            student.fullName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 6),

          Text(student.registrationNo),

          const SizedBox(height: 10),

          Text(
            "Department : ${student.department}",
          ),

          Text(
            "Semester : ${student.semester}",
          ),

          Text(
            "Section : ${student.section}",
          ),

        

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StudentDetailsPage(
                      student: student,
                    ),
                  ),
                );
              },
              child: const Text(
                "View Details",
              ),
            ),
          ),
        ],
      ),
    );
  }
}