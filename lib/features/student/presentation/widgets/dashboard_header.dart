import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_provider.dart';
import 'profile_avatar.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>().student;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -0.6,
                  height: 1.05,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Container(
                    height: 1,
                    width: 1,
                    decoration: BoxDecoration(
                      color: const Color(0xff2563EB),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff2563EB).withOpacity(0.8),
                          blurRadius: 1000,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    student.program,
                    style: const TextStyle(
                      color: Color(0xff64748B),
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Notification Bell
        const SizedBox(width: 14),

        /// Profile Avatar
        const ProfileAvatar(),
      ],
    );
  }
}