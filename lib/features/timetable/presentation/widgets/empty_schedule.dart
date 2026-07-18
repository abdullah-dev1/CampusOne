import 'package:flutter/material.dart';

class EmptySchedule extends StatelessWidget {
  const EmptySchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withOpacity(.06),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xff2563EB).withOpacity(.14),
                  const Color(0xff2563EB).withOpacity(.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.event_available_rounded,
              size: 46,
              color: Color(0xff2563EB),
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            "No Classes Today",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Color(0xff0F172A),
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "Your schedule is clear for today.\nTake this opportunity to revise, complete assignments, or relax.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2563EB).withOpacity(.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xff2563EB).withOpacity(0.14),
                width: 1,
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lightbulb_outline_rounded,
                  color: Color(0xff2563EB),
                  size: 19,
                ),
                SizedBox(width: 9),
                Text(
                  "Have a productive day!",
                  style: TextStyle(
                    color: Color(0xff2563EB),
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}