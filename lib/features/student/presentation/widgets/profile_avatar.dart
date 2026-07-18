import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_provider.dart';
import 'profile_bottom_sheet.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.watch<StudentProvider>().student;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const ProfileBottomSheet(),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff2563EB).withOpacity(0.18),
                width: 1.5,
              ),
            ),
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff2563EB).withOpacity(.32),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: ClipOval(
                child: student.profileImage.isNotEmpty
                    ? Image.asset(
                        student.profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 24,
                          );
                        },
                      )
                    : const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            right: -1,
            child: Container(
              height: 13,
              width: 13,
              decoration: BoxDecoration(
                color: const Color(0xff22C55E),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}