import 'package:flutter/material.dart';

import '../../data/models/lecturer_model.dart';

class LecturerDetailsPage extends StatelessWidget {
  final LecturerModel lecturer;

  const LecturerDetailsPage({
    super.key,
    required this.lecturer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Lecturer Details"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                lecturer.fullName[0],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              lecturer.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              lecturer.designation.name,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            _SectionTitle("Basic Information"),

            _InfoTile(
              "Employee ID",
              lecturer.employeeId,
            ),

            _InfoTile(
              "Email",
              lecturer.email,
            ),

            _InfoTile(
              "Phone",
              lecturer.phone,
            ),

            _InfoTile(
              "CNIC",
              lecturer.cnic,
            ),

            _InfoTile(
              "Gender",
              lecturer.gender.name,
            ),

            _InfoTile(
              "Date of Birth",
              lecturer.dateOfBirth,
            ),

            const SizedBox(height: 30),

            _SectionTitle("Academic Information"),

            _InfoTile(
              "Department",
              lecturer.department,
            ),

            _InfoTile(
              "Designation",
              lecturer.designation.name,
            ),

            _InfoTile(
              "Qualification",
              lecturer.qualification,
            ),

            _InfoTile(
              "Specialization",
              lecturer.specialization,
            ),

            _InfoTile(
              "Joining Date",
              lecturer.joiningDate,
            ),

            _InfoTile(
              "Office",
              lecturer.officeLocation,
            ),

            const SizedBox(height: 30),

            _SectionTitle("Address"),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Text(
                lecturer.address,
                style:
                    const TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(height: 30),

            _SectionTitle("Assigned Courses"),

          Wrap(
  spacing: 8,
  runSpacing: 8,
  children: lecturer.teachingAssignments
      .map((e) => e.course)
      .toSet()
      .map(
        (course) => Chip(
          label: Text(course),
        ),
      )
      .toList(),
),

            const SizedBox(height: 30),

            _SectionTitle("Assigned Sections"),

           Wrap(
  spacing: 8,
  runSpacing: 8,
  children: lecturer.teachingAssignments
      .map((e) => e.section)
      .toSet()
      .map(
        (section) => Chip(
          backgroundColor: Colors.blue.shade50,
          label: Text(section),
        ),
      )
      .toList(),
),

            const SizedBox(height: 30),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: lecturer.status ==
                        LecturerStatus.active
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius:
                    BorderRadius.circular(30),
              ),
              child: Text(
                lecturer.status ==
                        LecturerStatus.active
                    ? "ACTIVE"
                    : "INACTIVE",
                style: TextStyle(
                  color: lecturer.status ==
                          LecturerStatus.active
                      ? Colors.green
                      : Colors.red,
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 14),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile(
    this.title,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin:
          const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          value.isEmpty ? "-" : value,
        ),
      ),
    );
  }
}