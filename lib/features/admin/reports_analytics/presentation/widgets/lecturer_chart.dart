import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../lecturer_management/presentation/provider/lecturer_management_provider.dart';

class LecturerChart extends StatelessWidget {
  const LecturerChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<LecturerManagementProvider>();

    final data =
        provider.lecturersByDepartment;

    final maxValue =
        provider.maxDepartmentLecturers;

    final colors = [
      Colors.deepPurple,
      Colors.blue,
      Colors.green,
      Colors.orange,
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
                  color: Colors.deepPurple
                      .withOpacity(.12),
                  borderRadius:
                      BorderRadius.circular(
                          12),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color:
                      Colors.deepPurple,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Lecturers by Department",
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
            const SizedBox(
              height: 250,
              child: Center(
                child: Text(
                  "No Lecturer Data",
                ),
              ),
            )
          else
            SizedBox(
              height: 280,
              child: BarChart(
                BarChartData(
                  alignment:
                      BarChartAlignment
                          .spaceAround,
                  maxY:
                      (maxValue + 2)
                          .toDouble(),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine:
                        false,
                  ),
                  borderData:
                      FlBorderData(
                    show: false,
                  ),
                  titlesData:
                      FlTitlesData(
                    topTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles:
                            false,
                      ),
                    ),
                    rightTitles:
                        const AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles:
                            false,
                      ),
                    ),
                    leftTitles:
                        AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles:
                            true,
                        reservedSize:
                            30,
                      ),
                    ),
                    bottomTitles:
                        AxisTitles(
                      sideTitles:
                          SideTitles(
                        showTitles:
                            true,
                        getTitlesWidget:
                            (
                          value,
                          meta,
                        ) {
                          final list =
                              data.keys
                                  .toList();

                          if (value
                                  .toInt() >=
                              list.length) {
                            return const SizedBox();
                          }

                          String text =
                              list[value
                                  .toInt()];

                          final words =
                              text.split(
                                  " ");

                          if (words
                              .length >
                              1) {
                            text = words
                                .map(
                                  (e) =>
                                      e[0],
                                )
                                .join();
                          }

                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Text(
                              text,
                              style:
                                  const TextStyle(
                                fontSize:
                                    11,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: data.entries
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (
                          entry,
                        ) {
                          final index =
                              entry.key;

                          final item =
                              entry.value;

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: item
                                    .value
                                    .toDouble(),
                                width: 22,
                                borderRadius:
                                    BorderRadius.circular(
                                  6,
                                ),
                                color: colors[
                                    index %
                                        colors.length],
                              ),
                            ],
                          );
                        },
                      )
                      .toList(),
                ),
              ),
            ),

          const SizedBox(height: 28),

          const Divider(),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _StatusCard(
                  title: "Total",
                  value: provider
                      .totalLecturers
                      .toString(),
                  color: Colors.blue,
                  icon:
                      Icons.groups_rounded,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _StatusCard(
                  title: "Active",
                  value: provider
                      .activeLecturers
                      .toString(),
                  color: Colors.green,
                  icon:
                      Icons.check_circle,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _StatusCard(
                  title: "Inactive",
                  value: provider
                      .inactiveLecturers
                      .toString(),
                  color: Colors.red,
                  icon: Icons.cancel,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: _StatusCard(
                  title:
                      "Departments",
                  value: provider
                      .departmentCount
                      .toString(),
                  color:
                      Colors.deepPurple,
                  icon:
                      Icons.apartment,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatusCard({
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
        border: Border.all(
          color: color.withOpacity(.15),
        ),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}