import 'package:flutter/material.dart';

class GradeChip extends StatelessWidget {
  final String grade;

  const GradeChip({
    super.key,
    required this.grade,
  });

  Color get _backgroundColor {
    switch (grade) {
      case "A+":
      case "A":
        return const Color(0xffDCFCE7);
      case "A-":
        return const Color(0xffDBEAFE);
      case "B+":
      case "B":
        return const Color(0xffFEF3C7);
      case "C+":
      case "C":
        return const Color(0xffFEE2E2);
      default:
        return Colors.grey.shade200;
    }
  }

  Color get _textColor {
    switch (grade) {
      case "A+":
      case "A":
        return const Color(0xff15803D);
      case "A-":
        return const Color(0xff2563EB);
      case "B+":
      case "B":
        return const Color(0xffD97706);
      case "C+":
      case "C":
        return const Color(0xffDC2626);
      default:
        return Colors.black87;
    }
  }

  Color get _borderColor {
    switch (grade) {
      case "A+":
      case "A":
        return const Color(0xff22C55E).withOpacity(0.25);
      case "A-":
        return const Color(0xff2563EB).withOpacity(0.2);
      case "B+":
      case "B":
        return const Color(0xffF59E0B).withOpacity(0.25);
      case "C+":
      case "C":
        return const Color(0xffEF4444).withOpacity(0.2);
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _textColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        grade,
        style: TextStyle(
          color: _textColor,
          fontWeight: FontWeight.w800,
          fontSize: 13,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}