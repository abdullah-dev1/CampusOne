import 'package:flutter/material.dart';

class AssignmentStatusChip extends StatelessWidget {
  final bool submitted;
  final bool late;

  const AssignmentStatusChip({
    super.key,
    required this.submitted,
    required this.late,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;
    String text;

    if (submitted) {
      color = const Color(0xff22C55E);
      icon = Icons.check_circle_rounded;
      text = "Submitted";
    } else if (late) {
      color = const Color(0xffEF4444);
      icon = Icons.warning_rounded;
      text = "Late";
    } else {
      color = const Color(0xffF59E0B);
      icon = Icons.schedule_rounded;
      text = "Pending";
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(.14),
            color.withOpacity(.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}