import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../admin/student_management/data/models/student_model.dart';
import '../provider/grade_provider.dart';

class GradeStudentCard extends StatelessWidget {
  final int index;

  const GradeStudentCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradeProvider>();

    final StudentModel student =
        provider.filteredStudents[index];

    final marksController = TextEditingController(
      text: provider
          .marksOf(student)
          .toStringAsFixed(0),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Colors.blue.shade100,
                  child: Text(
                    student.fullName.isEmpty
                        ? "?"
                        : student.fullName[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student.registrationNo,
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: provider
                            .studentPassed(
                                student)
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: Text(
                    provider.gradeLetter(
                        student),
                    style: TextStyle(
                      color: provider
                              .studentPassed(
                                  student)
                          ? Colors.green
                          : Colors.red,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

TextField(
  controller: TextEditingController(
    text: provider
        .marksOf(student)
        .toStringAsFixed(0),
  )..selection = TextSelection.fromPosition(
      TextPosition(
        offset: provider
            .marksOf(student)
            .toStringAsFixed(0)
            .length,
      ),
    ),

  keyboardType: const TextInputType.numberWithOptions(
    decimal: true,
  ),

  enabled: true,

  decoration: InputDecoration(
    labelText: "Obtained Marks",
    suffixText:
        "/ ${provider.totalMarks.toStringAsFixed(0)}",
    border: const OutlineInputBorder(),
  ),

  onChanged: (value) async {
    final marks = double.tryParse(value) ?? 0;

    await provider.updateMarks(
      student,
      marks,
    );
  },
),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _infoTile(
                    "Percentage",
                    "${provider.calculatePercentage(provider.marksOf(student)).toStringAsFixed(1)} %",
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _infoTile(
                    "Result",
                    provider.studentPassed(
                            student)
                        ? "PASS"
                        : "FAIL",
                    provider.studentPassed(
                            student)
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}