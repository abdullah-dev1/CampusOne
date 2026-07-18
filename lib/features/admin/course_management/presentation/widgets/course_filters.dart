import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/course_model.dart';
import '../provider/course_management_provider.dart';

class CourseFilters extends StatelessWidget {
  const CourseFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseManagementProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: "Search by Course Name or Code",

                prefixIcon: const Icon(Icons.search),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: provider.searchCourses,
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Expanded(
  child: DropdownButtonFormField<String>(
    value: provider.selectedDepartment,
    isExpanded: true,
    decoration: InputDecoration(
      labelText: "Department",
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    items: provider.departments.map((department) {
      return DropdownMenuItem(
        value: department,
        child: Text(
          department,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList(),
    onChanged: (value) {
      provider.filterDepartment(value!);
    },
  ),
),

                const SizedBox(width: 16),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: provider.selectedSemester,

                    decoration: InputDecoration(
                      labelText: "Semester",

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),

                    items: [

                      const DropdownMenuItem(
                        value: "All",
                        child: Text("All"),
                      ),

                      ...List.generate(
                        8,
                        (index) => DropdownMenuItem(
                          value: "${index + 1}",
                          child: Text(
                            "Semester ${index + 1}",
                          ),
                        ),
                      ),

                    ],

                    onChanged: (value) {
                      provider.filterSemester(value!);
                    },
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<CourseType?>(
  value: provider.selectedType,

  decoration: InputDecoration(
    labelText: "Course Type",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  items: const [
    DropdownMenuItem(
      value: null,
      child: Text("All Courses"),
    ),
    DropdownMenuItem(
      value: CourseType.core,
      child: Text("Core"),
    ),
    DropdownMenuItem(
      value: CourseType.elective,
      child: Text("Elective"),
    ),
  ],

  onChanged: (value) {
    provider.filterType(value);
  },
),

          ],
        );
      },
    );
  }
}