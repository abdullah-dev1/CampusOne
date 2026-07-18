import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lecturer_provider.dart';

class LecturerInfoCard extends StatelessWidget {
  const LecturerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final lecturerProvider =
        context.watch<LecturerProvider>();

    final lecturer = lecturerProvider.lecturer;

    if (lecturer == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Text(
              "No Lecturer Information Found",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Lecturer Information",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    Icons.badge,
                    "Employee ID",
                    lecturer.employeeId,
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    Icons.school,
                    "Designation",
                    lecturer.designation.name
                        .replaceAllMapped(
                      RegExp(r'([A-Z])'),
                      (m) => ' ${m.group(0)}',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    Icons.apartment,
                    "Department",
                    lecturer.department,
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    Icons.location_on,
                    "Office",
                    lecturer.officeLocation,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    Icons.email,
                    "Email",
                    lecturer.email,
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    Icons.phone,
                    "Phone",
                    lecturer.phone,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            Row(
              children: [

                Expanded(
                  child: _infoTile(
                    Icons.workspace_premium,
                    "Qualification",
                    lecturer.qualification,
                  ),
                ),

                Expanded(
                  child: _infoTile(
                    Icons.psychology,
                    "Specialization",
                    lecturer.specialization,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            _infoTile(
              Icons.home,
              "Address",
              lecturer.address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value.isEmpty ? "-" : value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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