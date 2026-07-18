import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../course_management/presentation/provider/course_management_provider.dart';

class CourseChart extends StatelessWidget {
  const CourseChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseManagementProvider>();

    final data = provider.coursesByType;

    final totalCourses = data.values.fold(
      0,
      (sum, value) => sum + value,
    );

    final colors = [
      Colors.blue,
      Colors.orange,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Courses by Type",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          if (data.isEmpty || totalCourses == 0)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("No Course Data"),
              ),
            )
          else ...[
            SizedBox(
              height: 270,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 70,
                  sectionsSpace: 4,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sections: data.entries.toList().asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return PieChartSectionData(
                        color: colors[index % colors.length],
                        radius: 70,
                        value: item.value.toDouble(),
                        title:
                            "${((item.value / totalCourses) * 100).toStringAsFixed(0)}%",
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 20,
              runSpacing: 14,
              children: data.entries.toList().asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: colors[index % colors.length],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${item.key} (${item.value})",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ],

          const SizedBox(height: 28),

          const Divider(),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _CourseStatusCard(
                  title: "Active",
                  value: provider.activeCourses.toString(),
                  color: Colors.green,
                  icon: Icons.check_circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _CourseStatusCard(
                  title: "Inactive",
                  value: provider.inactiveCourses.toString(),
                  color: Colors.red,
                  icon: Icons.cancel,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _CourseStatusCard(
                  title: "Total Courses",
                  value: provider.totalCourses.toString(),
                  color: Colors.blue,
                  icon: Icons.menu_book_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _CourseStatusCard(
                  title: "Departments",
                  value: provider.totalDepartments.toString(),
                  color: Colors.deepPurple,
                  icon: Icons.apartment_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CourseStatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _CourseStatusCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}