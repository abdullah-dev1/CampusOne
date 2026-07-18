import 'package:flutter/material.dart';

import '../../data/models/grade_model.dart';
import '../provider/grade_provider.dart';

class StudentGradeDialog extends StatelessWidget {
  final GradeModel student;
  final GradeProvider provider;

  const StudentGradeDialog({
    super.key,
    required this.student,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final percentage =
        provider.calculatePercentage(student.obtainedMarks);

    final grade =
        provider.calculateGrade(student.obtainedMarks);

    final passed =
        provider.isPass(student.obtainedMarks);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Student Grade Details",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _infoTile(
                "Student",
                student.studentName,
              ),

              _infoTile(
                "Registration No",
                student.registrationNo,
              ),

              _infoTile(
                "Course",
                student.course,
              ),

              _infoTile(
                "Section",
                student.section,
              ),

              _infoTile(
                "Assessment",
                student.assessment,
              ),

              const Divider(height: 30),

              _infoTile(
                "Obtained Marks",
                student.obtainedMarks
                    .toStringAsFixed(1),
              ),

              _infoTile(
                "Total Marks",
                student.totalMarks
                    .toStringAsFixed(1),
              ),

              _infoTile(
                "Percentage",
                "${percentage.toStringAsFixed(1)}%",
              ),

              _infoTile(
                "Grade",
                grade,
              ),

              _infoTile(
                "Result",
                passed ? "PASS" : "FAIL",
                valueColor: passed
                    ? Colors.green
                    : Colors.red,
              ),

              _infoTile(
                "Status",
                student.published
                    ? "Published"
                    : "Draft",
                valueColor: student.published
                    ? Colors.green
                    : Colors.orange,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}