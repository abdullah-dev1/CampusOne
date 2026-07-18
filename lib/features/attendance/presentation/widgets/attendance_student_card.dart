import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/attendance_model.dart';
import '../provider/attendance_provider.dart';

class AttendanceStudentCard extends StatelessWidget {
  final int index;

  const AttendanceStudentCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceProvider>();
    final student = provider.students[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xffDBEAFE),
                child: Text(
                  student.studentName[0],
                  style: const TextStyle(
                    color: Color(0xff2563EB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      student.studentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      student.registrationNo,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              Expanded(
                child: _statusButton(
                  context,
                  "Present",
                  Colors.green,
                  AttendanceStatus.present,
                  student,
                  index,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _statusButton(
                  context,
                  "Absent",
                  Colors.red,
                  AttendanceStatus.absent,
                  student,
                  index,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _statusButton(
                  context,
                  "Late",
                  Colors.orange,
                  AttendanceStatus.late,
                  student,
                  index,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _statusButton(
    BuildContext context,
    String text,
    Color color,
    AttendanceStatus status,
    AttendanceModel student,
    int index,
  ) {
    final selected = student.status == status;

    return ElevatedButton(
      onPressed: () {
        context
            .read<AttendanceProvider>()
            .updateAttendance(index, status);
      },

      style: ElevatedButton.styleFrom(
        backgroundColor:
            selected ? color : Colors.grey.shade200,

        foregroundColor:
            selected ? Colors.white : Colors.black87,

        elevation: 0,
      ),

      child: Text(text),
    );
  }
}