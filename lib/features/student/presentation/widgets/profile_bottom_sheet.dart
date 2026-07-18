import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/student_provider.dart';
import '../../data/models/student_model.dart';
import 'change_password_dialog.dart';
import 'logout_dialog.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>().student;

    return Container(
      height: MediaQuery.of(context).size.height * .82,
      decoration: const BoxDecoration(
        color: Color(0xffF8FAFC),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              /// Drag Handle
              Container(
                width: 55,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 24),

              /// Profile Picture
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff2563EB).withOpacity(.15),
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff2563EB),
                        Color(0xff1D4ED8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff2563EB).withOpacity(.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: student.profileImage.isNotEmpty
                        ? Image.asset(
                            student.profileImage,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Center(
                                child: Text(
                                  student.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34,
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              student.name[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                              ),
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                student.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -.3,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2563EB).withOpacity(.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  student.program,
                  style: const TextStyle(
                    color: Color(0xff2563EB),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ),

              const SizedBox(height: 26),

              Expanded(
                child: ListView(
                  children: [

                  _ProfileTile(
  icon: Icons.badge_outlined,
  title: "Registration Number",
  value: student.registrationNo,
),

_ProfileTile(
  icon: Icons.school_outlined,
  title: "Department",
  value: student.department,
),

_ProfileTile(
  icon: Icons.calendar_today_outlined,
  title: "Semester",
  value: student.semester,
),

_ProfileTile(
  icon: Icons.groups_outlined,
  title: "Session",
  value: student.session,
),

_ProfileTile(
  icon: Icons.email_outlined,
  title: "University Email",
  value: student.email,
),



const _ProfileTile(
  icon: Icons.verified_user_outlined,
  title: "Status",
  value: "Active Student",
),

const SizedBox(height: 20),

SizedBox(
  height: 52,
  child: OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.red),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    icon: const Icon(
      Icons.logout,
      color: Colors.red,
    ),
    label: const Text(
      "Logout",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => LogoutDialog(
          onLogout: () {
            context.go('/login');
          },
        ),
      );
    },
  ),
),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        leading: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff2563EB).withOpacity(.16),
                const Color(0xff2563EB).withOpacity(.08),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xff2563EB),
            size: 20,
          ),
        ),

        title: Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xff0F172A),
              letterSpacing: -.1,
            ),
          ),
        ),
      ),
    );
  }
}