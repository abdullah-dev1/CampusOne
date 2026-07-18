import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/service_locator.dart';

import '../../domain/repository/course_repository.dart';
import '../provider/course_management_provider.dart';

import '../widgets/course_header.dart';
import '../widgets/course_statistics.dart';
import '../widgets/course_filters.dart';
import '../widgets/course_card.dart';

import 'add_edit_course_page.dart';

class CourseManagementPage extends StatelessWidget {
  const CourseManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseManagementProvider(
      locator<CourseRepository>(),
    ),

      child: Consumer<CourseManagementProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: const Color(0xffF8FAFC),

            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text(
                "Course Management",
              ),
            ),

            floatingActionButton:
                FloatingActionButton.extended(
              icon: const Icon(Icons.add),

              label: const Text(
                "Add Course",
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ChangeNotifierProvider.value(
                      value: provider,
                      child: const AddEditCoursePage(),
                    ),
                  ),
                );
              },
            ),

            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),

                children: [

                  /// HEADER
                  const CourseHeader(),

                  const SizedBox(height: 28),

                  /// STATISTICS
                  const CourseStatistics(),

                  const SizedBox(height: 28),

                  /// FILTERS
                  const CourseFilters(),

                  const SizedBox(height: 28),

                  /// COURSE LIST
                  if (provider.courses.isEmpty)

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 80,
                      ),

                      child: const Center(
                        child: Column(
                          children: [

                            Icon(
                              Icons.menu_book_outlined,
                              size: 90,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 20),

                            Text(
                              "No Courses Found",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Try changing filters or add a new course.",
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      ),
                    )

                  else

                    ...provider.courses.map(
                      (course) => CourseCard(
                        course: course,
                      ),
                    ),

                  const SizedBox(height: 100),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}