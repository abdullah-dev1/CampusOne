import 'package:flutter/material.dart';

import '../../data/models/assignment_model.dart';
import 'assignment_progress_card.dart';
import 'assignment_status_chip.dart';

class AssignmentCard extends StatelessWidget {
  final AssignmentModel assignment;

  const AssignmentCard({
    super.key,
    required this.assignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: assignment.color.withOpacity(.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //-------------------------------------------------
          // TOP ROW
          //-------------------------------------------------

          Row(
            children: [

              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      assignment.color.withOpacity(.18),
                      assignment.color.withOpacity(.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.assignment_rounded,
                  color: assignment.color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      assignment.subject,
                      style: TextStyle(
                        color: assignment.color,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      assignment.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Color(0xff0F172A),
                        letterSpacing: -.3,
                      ),
                    ),
                  ],
                ),
              ),

              AssignmentStatusChip(
                submitted: assignment.submitted,
                late: assignment.late,
              ),
            ],
          ),

          const SizedBox(height: 22),

          //-------------------------------------------------
          // Lecturer
          //-------------------------------------------------

          Row(
            children: [

              Icon(
                Icons.person_outline_rounded,
                size: 18,
                color: Colors.grey.shade600,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  assignment.lecturer,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          //-------------------------------------------------
          // Due Date
          //-------------------------------------------------

          Row(
            children: [

              Icon(
                Icons.calendar_today_rounded,
                size: 17,
                color: Colors.grey.shade600,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  assignment.dueDate,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Text(
                assignment.remainingDays < 0
                    ? "Overdue"
                    : "${assignment.remainingDays} days left",
                style: TextStyle(
                  color: assignment.remainingDays < 0
                      ? Colors.red
                      : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          AssignmentProgressCard(
            progress: assignment.progress,
          ),

          const SizedBox(height: 24),

          //-------------------------------------------------
          // Buttons
          //-------------------------------------------------

          Row(
            children: [

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.attach_file_rounded),

                  label: const Text("Attachment"),

                  style: OutlinedButton.styleFrom(
                    foregroundColor: assignment.color,
                    side: BorderSide(
                      color: assignment.color.withOpacity(.35),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: assignment.submitted
                      ? null
                      : () {},

                  icon: Icon(
                    assignment.submitted
                        ? Icons.check
                        : Icons.upload_rounded,
                  ),

                  label: Text(
                    assignment.submitted
                        ? "Submitted"
                        : "Submit",
                  ),

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: assignment.color,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}