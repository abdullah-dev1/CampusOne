import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../student_management/presentation/provider/student_management_provider.dart';

class StudentChart extends StatelessWidget {
  const StudentChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<StudentManagementProvider>();

    final data =
        provider.studentsByDepartment;

    final totalStudents =
        data.values.fold(
      0,
      (sum, value) => sum + value,
    );

    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.brown,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue
                      .withOpacity(.12),
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Students by Department",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          if (data.isEmpty)
            const Padding(
              padding:
                  EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Center(
                child: Text(
                  "No Student Data",
                ),
              ),
            )
          else ...[
            SizedBox(
              height: 280,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 70,
                  borderData:
                      FlBorderData(
                    show: false,
                  ),
                  sections: data.entries
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (entry) {
                          final index =
                              entry.key;

                          final item =
                              entry.value;

                          return PieChartSectionData(
                            color: colors[
                                index %
                                    colors.length],
                            value: item.value
                                .toDouble(),
                            radius: 70,
                            title:
                                "${((item.value / totalStudents) * 100).toStringAsFixed(0)}%",
                            titleStyle:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize: 14,
                            ),
                          );
                        },
                      )
                      .toList(),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Wrap(
              spacing: 18,
              runSpacing: 14,
              children: data.entries
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (entry) {
                      final index =
                          entry.key;

                      final item =
                          entry.value;

                      return Row(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration:
                                BoxDecoration(
                              color: colors[
                                  index %
                                      colors.length],
                              borderRadius:
                                  BorderRadius.circular(
                                      4),
                            ),
                          ),

                          const SizedBox(
                              width: 8),

                          Text(
                            "${item.key} (${item.value})",
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}