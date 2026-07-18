import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_management_provider.dart';

class StudentFilters extends StatelessWidget {
  const StudentFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StudentManagementProvider>();

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Search & Filters",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            decoration: const InputDecoration(
              hintText: "Search by name, registration or email",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: provider.searchStudent,
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: provider.selectedDepartment,
            decoration: const InputDecoration(
              labelText: "Department",
              border: OutlineInputBorder(),
            ),
            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All Departments"),
              ),

              DropdownMenuItem(
                value: "BS Computer Science",
                child: Text("BS Computer Science"),
              ),

              DropdownMenuItem(
                value: "BS Software Engineering",
                child: Text("BS Software Engineering"),
              ),

              DropdownMenuItem(
                value: "BS Artificial Intelligence",
                child: Text("BS Artificial Intelligence"),
              ),

            ],
            onChanged: (value) {
              if (value != null) {
                provider.changeDepartment(value);
              }
            },
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: provider.selectedSemester,
            decoration: const InputDecoration(
              labelText: "Semester",
              border: OutlineInputBorder(),
            ),
            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All Semesters"),
              ),

              DropdownMenuItem(value: "1", child: Text("Semester 1")),
              DropdownMenuItem(value: "2", child: Text("Semester 2")),
              DropdownMenuItem(value: "3", child: Text("Semester 3")),
              DropdownMenuItem(value: "4", child: Text("Semester 4")),
              DropdownMenuItem(value: "5", child: Text("Semester 5")),
              DropdownMenuItem(value: "6", child: Text("Semester 6")),
              DropdownMenuItem(value: "7", child: Text("Semester 7")),
              DropdownMenuItem(value: "8", child: Text("Semester 8")),

            ],
            onChanged: (value) {
              if (value != null) {
                provider.changeSemester(value);
              }
            },
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: provider.selectedSection,
            decoration: const InputDecoration(
              labelText: "Section",
              border: OutlineInputBorder(),
            ),
            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All Sections"),
              ),

             DropdownMenuItem(value: "BSCS-1A", child: Text("BSCS-1A")),
DropdownMenuItem(value: "BSCS-1B", child: Text("BSCS-1B")),
DropdownMenuItem(value: "BSCS-1C", child: Text("BSCS-1C")),
DropdownMenuItem(value: "BSCS-1D", child: Text("BSCS-1D")),
DropdownMenuItem(value: "BSCS-1E", child: Text("BSCS-1E")),
DropdownMenuItem(value: "BSCS-1F", child: Text("BSCS-1F")),

DropdownMenuItem(value: "BSCS-2A", child: Text("BSCS-2A")),
DropdownMenuItem(value: "BSCS-2B", child: Text("BSCS-2B")),
DropdownMenuItem(value: "BSCS-2C", child: Text("BSCS-2C")),
DropdownMenuItem(value: "BSCS-2D", child: Text("BSCS-2D")),
DropdownMenuItem(value: "BSCS-2E", child: Text("BSCS-2E")),
DropdownMenuItem(value: "BSCS-2F", child: Text("BSCS-2F")),

DropdownMenuItem(value: "BSCS-3A", child: Text("BSCS-3A")),
DropdownMenuItem(value: "BSCS-3B", child: Text("BSCS-3B")),
DropdownMenuItem(value: "BSCS-3C", child: Text("BSCS-3C")),
DropdownMenuItem(value: "BSCS-3D", child: Text("BSCS-3D")),
DropdownMenuItem(value: "BSCS-3E", child: Text("BSCS-3E")),
DropdownMenuItem(value: "BSCS-3F", child: Text("BSCS-3F")),

DropdownMenuItem(value: "BSCS-4A", child: Text("BSCS-4A")),
DropdownMenuItem(value: "BSCS-4B", child: Text("BSCS-4B")),
DropdownMenuItem(value: "BSCS-4C", child: Text("BSCS-4C")),
DropdownMenuItem(value: "BSCS-4D", child: Text("BSCS-4D")),
DropdownMenuItem(value: "BSCS-4E", child: Text("BSCS-4E")),
DropdownMenuItem(value: "BSCS-4F", child: Text("BSCS-4F")),

DropdownMenuItem(value: "BSCS-5A", child: Text("BSCS-5A")),
DropdownMenuItem(value: "BSCS-5B", child: Text("BSCS-5B")),
DropdownMenuItem(value: "BSCS-5C", child: Text("BSCS-5C")),
DropdownMenuItem(value: "BSCS-5D", child: Text("BSCS-5D")),
DropdownMenuItem(value: "BSCS-5E", child: Text("BSCS-5E")),
DropdownMenuItem(value: "BSCS-5F", child: Text("BSCS-5F")),

DropdownMenuItem(value: "BSCS-6A", child: Text("BSCS-6A")),
DropdownMenuItem(value: "BSCS-6B", child: Text("BSCS-6B")),
DropdownMenuItem(value: "BSCS-6C", child: Text("BSCS-6C")),
DropdownMenuItem(value: "BSCS-6D", child: Text("BSCS-6D")),
DropdownMenuItem(value: "BSCS-6E", child: Text("BSCS-6E")),
DropdownMenuItem(value: "BSCS-6F", child: Text("BSCS-6F")),

DropdownMenuItem(value: "BSCS-7A", child: Text("BSCS-7A")),
DropdownMenuItem(value: "BSCS-7B", child: Text("BSCS-7B")),
DropdownMenuItem(value: "BSCS-7C", child: Text("BSCS-7C")),
DropdownMenuItem(value: "BSCS-7D", child: Text("BSCS-7D")),
DropdownMenuItem(value: "BSCS-7E", child: Text("BSCS-7E")),
DropdownMenuItem(value: "BSCS-7F", child: Text("BSCS-7F")),

DropdownMenuItem(value: "BSCS-8A", child: Text("BSCS-8A")),
DropdownMenuItem(value: "BSCS-8B", child: Text("BSCS-8B")),
DropdownMenuItem(value: "BSCS-8C", child: Text("BSCS-8C")),
DropdownMenuItem(value: "BSCS-8D", child: Text("BSCS-8D")),
DropdownMenuItem(value: "BSCS-8E", child: Text("BSCS-8E")),
DropdownMenuItem(value: "BSCS-8F", child: Text("BSCS-8F")),

DropdownMenuItem(value: "BSSE-1A", child: Text("BSSE-1A")),
DropdownMenuItem(value: "BSSE-1B", child: Text("BSSE-1B")),
DropdownMenuItem(value: "BSSE-2A", child: Text("BSSE-2A")),
DropdownMenuItem(value: "BSSE-2B", child: Text("BSSE-2B")),
DropdownMenuItem(value: "BSSE-3A", child: Text("BSSE-3A")),
DropdownMenuItem(value: "BSSE-3B", child: Text("BSSE-3B")),
DropdownMenuItem(value: "BSSE-4A", child: Text("BSSE-4A")),
DropdownMenuItem(value: "BSSE-4B", child: Text("BSSE-4B")),
DropdownMenuItem(value: "BSSE-5A", child: Text("BSSE-5A")),
DropdownMenuItem(value: "BSSE-5B", child: Text("BSSE-5B")),
DropdownMenuItem(value: "BSSE-6A", child: Text("BSSE-6A")),
DropdownMenuItem(value: "BSSE-6B", child: Text("BSSE-6B")),
DropdownMenuItem(value: "BSSE-7A", child: Text("BSSE-7A")),
DropdownMenuItem(value: "BSSE-7B", child: Text("BSSE-7B")),
DropdownMenuItem(value: "BSSE-8A", child: Text("BSSE-8A")),
DropdownMenuItem(value: "BSSE-8B", child: Text("BSSE-8B")),

DropdownMenuItem(value: "BSAI-1A", child: Text("BSAI-1A")),
DropdownMenuItem(value: "BSAI-1B", child: Text("BSAI-1B")),
DropdownMenuItem(value: "BSAI-2A", child: Text("BSAI-2A")),
DropdownMenuItem(value: "BSAI-2B", child: Text("BSAI-2B")),
DropdownMenuItem(value: "BSAI-3A", child: Text("BSAI-3A")),
DropdownMenuItem(value: "BSAI-3B", child: Text("BSAI-3B")),
DropdownMenuItem(value: "BSAI-4A", child: Text("BSAI-4A")),
DropdownMenuItem(value: "BSAI-4B", child: Text("BSAI-4B")),
DropdownMenuItem(value: "BSAI-5A", child: Text("BSAI-5A")),
DropdownMenuItem(value: "BSAI-5B", child: Text("BSAI-5B")),
DropdownMenuItem(value: "BSAI-6A", child: Text("BSAI-6A")),
DropdownMenuItem(value: "BSAI-6B", child: Text("BSAI-6B")),
DropdownMenuItem(value: "BSAI-7A", child: Text("BSAI-7A")),
DropdownMenuItem(value: "BSAI-7B", child: Text("BSAI-7B")),
DropdownMenuItem(value: "BSAI-8A", child: Text("BSAI-8A")),
DropdownMenuItem(value: "BSAI-8B", child: Text("BSAI-8B")),

            ],
            onChanged: (value) {
              if (value != null) {
                provider.changeSection(value);
              }
            },
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: provider.selectedStatus,
            decoration: const InputDecoration(
              labelText: "Status",
              border: OutlineInputBorder(),
            ),
            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All Students"),
              ),

              DropdownMenuItem(
                value: "Active",
                child: Text("Active"),
              ),

              DropdownMenuItem(
                value: "Inactive",
                child: Text("Inactive"),
              ),

            ],
            onChanged: (value) {
              if (value != null) {
                provider.changeStatus(value);
              }
            },
          ),

        ],
      ),
    );
  }
}