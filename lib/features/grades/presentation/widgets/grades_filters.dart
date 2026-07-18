import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/grade_provider.dart';

class GradesFilters extends StatelessWidget {
  const GradesFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradeProvider>();

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
            "Grade Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20),

          /// COURSE
          DropdownButtonFormField<String>(
            value: provider.availableCourses.contains(provider.selectedCourse)
                ? provider.selectedCourse
                : null,
            decoration: const InputDecoration(
              labelText: "Course",
              border: OutlineInputBorder(),
            ),
            items: provider.availableCourses
                .map(
                  (course) => DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                provider.changeCourse(value);
              }
            },
          ),

          const SizedBox(height: 18),

          /// SECTION
          DropdownButtonFormField<String>(
            value: provider.availableSections.contains(provider.selectedSection)
                ? provider.selectedSection
                : null,
            decoration: const InputDecoration(
              labelText: "Section",
              border: OutlineInputBorder(),
            ),
            items: provider.availableSections
                .map(
                  (section) => DropdownMenuItem(
                    value: section,
                    child: Text(section),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                provider.changeSection(value);
              }
            },
          ),

          const SizedBox(height: 18),

          /// ASSESSMENT
          DropdownButtonFormField<String>(
            value: provider.selectedAssessment,
            decoration: const InputDecoration(
              labelText: "Assessment",
              border: OutlineInputBorder(),
            ),
            items: provider.assessmentMarks.keys
                .map(
                  (assessment) => DropdownMenuItem(
                    value: assessment,
                    child: Text(assessment),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                provider.changeAssessment(value);
              }
            },
          ),

          const SizedBox(height: 18),

          /// TOTAL MARKS
          TextFormField(
            initialValue: provider.totalMarks.toStringAsFixed(0),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Total Marks",
              border: OutlineInputBorder(),
            ),
            onChanged: provider.changeTotalMarks,
          ),

          const SizedBox(height: 18),

          /// SEARCH
          TextField(
            decoration: const InputDecoration(
              hintText: "Search Student",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: provider.searchStudent,
          ),
        ],
      ),
    );
  }
}