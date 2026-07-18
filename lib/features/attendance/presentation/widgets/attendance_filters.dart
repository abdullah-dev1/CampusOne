import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/attendance_provider.dart';

class AttendanceFilters extends StatelessWidget {
  const AttendanceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = context.watch<AttendanceProvider>();
   
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Attendance Filters",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

         DropdownButtonFormField<String>(
  value: attendanceProvider.selectedCourse.isEmpty
      ? null
      : attendanceProvider.selectedCourse,
  isExpanded: true,
  decoration: InputDecoration(
    labelText: "Course",
    prefixIcon: const Icon(Icons.menu_book_rounded),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  items: attendanceProvider.availableCourses
      .map(
        (course) => DropdownMenuItem<String>(
          value: course,
          child: Text(course),
        ),
      )
      .toList(),
  onChanged: attendanceProvider.availableCourses.isEmpty
      ? null
      : (value) {
          if (value != null) {
            attendanceProvider.changeCourse(value);
          }
        },
),

          const SizedBox(height: 18),

         DropdownButtonFormField<String>(
  value: attendanceProvider.selectedSection.isEmpty
      ? null
      : attendanceProvider.selectedSection,
  isExpanded: true,
  decoration: InputDecoration(
    labelText: "Section",
    prefixIcon: const Icon(Icons.groups_rounded),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  items: attendanceProvider.availableSections
      .map(
        (section) => DropdownMenuItem<String>(
          value: section,
          child: Text(section),
        ),
      )
      .toList(),
  onChanged: attendanceProvider.availableSections.isEmpty
      ? null
      : (value) {
          if (value != null) {
            attendanceProvider.changeSection(value);
          }
        },
),

          const SizedBox(height: 18),

          TextField(
            onChanged: attendanceProvider.searchStudent,
            decoration: InputDecoration(
              hintText: "Search Student...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.calendar_month_rounded),
              label: Text(attendanceProvider.selectedDate),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2035),
                );

                if (pickedDate != null) {
                  attendanceProvider.changeDate(pickedDate);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}