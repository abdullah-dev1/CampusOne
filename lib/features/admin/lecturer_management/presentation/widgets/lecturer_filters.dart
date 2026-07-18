import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/lecturer_model.dart';
import '../provider/lecturer_management_provider.dart';

class LecturerFilters extends StatelessWidget {
  const LecturerFilters({super.key});

  InputDecoration _decoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey.shade600,
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: icon != null
          ? Icon(icon, color: Colors.grey.shade500, size: 20)
          : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade100, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xff7C3AED), width: 1.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LecturerManagementProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500),
            cursorColor: const Color(0xff7C3AED),
            decoration: _decoration("Search lecturer...", icon: Icons.search_rounded),
            onChanged: provider.searchLecturers,
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
  value: provider.selectedDepartment,
  isExpanded: true,
  decoration: _decoration("Department"),
  style: const TextStyle(
    color: Color(0xff0F172A),
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  items: const [
    DropdownMenuItem(
      value: "All",
      child: Text("All", overflow: TextOverflow.ellipsis),
    ),
    DropdownMenuItem(
      value: "BS Computer Science",
      child: Text("Computer Science", overflow: TextOverflow.ellipsis),
    ),
    DropdownMenuItem(
      value: "BS Software Engineering",
      child: Text("Software Engineering", overflow: TextOverflow.ellipsis),
    ),
    DropdownMenuItem(
      value: "BS Artificial Intelligence",
      child: Text("Artificial Intelligence", overflow: TextOverflow.ellipsis),
    ),
    DropdownMenuItem(
      value: "BS Information Technology",
      child: Text("Information Technology", overflow: TextOverflow.ellipsis),
    ),
  ],
  onChanged: (value) {
    provider.filterDepartment(value!);
  },
),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<LecturerStatus?>(
                  value: provider.selectedStatus,
                  decoration: _decoration("Status"),
                  style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  items: const [
                    DropdownMenuItem(value: null, child: Text("All")),
                    DropdownMenuItem(
                      value: LecturerStatus.active,
                      child: Text("Active"),
                    ),
                    DropdownMenuItem(
                      value: LecturerStatus.inactive,
                      child: Text("Inactive"),
                    ),
                  ],
                  onChanged: (value) {
                    provider.filterStatus(value);
                  },
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<LecturerDesignation?>(
            value: provider.selectedDesignation,
            decoration: _decoration("Designation"),
            style: const TextStyle(
              color: Color(0xff0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            items: const [
              DropdownMenuItem(value: null, child: Text("All")),
              DropdownMenuItem(
                value: LecturerDesignation.professor,
                child: Text("Professor"),
              ),
              DropdownMenuItem(
                value: LecturerDesignation.associateProfessor,
                child: Text("Associate Professor"),
              ),
              DropdownMenuItem(
                value: LecturerDesignation.assistantProfessor,
                child: Text("Assistant Professor"),
              ),
              DropdownMenuItem(
                value: LecturerDesignation.lecturer,
                child: Text("Lecturer"),
              ),
              DropdownMenuItem(
                value: LecturerDesignation.labEngineer,
                child: Text("Lab Engineer"),
              ),
            ],
            onChanged: (value) {
              provider.filterDesignation(value);
            },
          ),
        ),
      ],
    );
  }
}