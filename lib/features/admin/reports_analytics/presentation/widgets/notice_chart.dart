import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../notice_management/presentation/provider/notice_management_provider.dart';

class NoticeChart extends StatelessWidget {
  const NoticeChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeManagementProvider>();

    final data = provider.noticesByCategory;

    final total = data.values.fold(
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
                  color: Colors.red.withOpacity(.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.campaign_rounded,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Notice Analytics",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          if (data.isEmpty || total == 0)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("No Notice Data"),
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
                        value: item.value.toDouble(),
                        radius: 70,
                        color: colors[index % colors.length],
                        title:
                            "${((item.value / total) * 100).toStringAsFixed(0)}%",
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
                child: _MetricCard(
                  title: "Published",
                  value: provider.publishedCount.toString(),
                  color: Colors.green,
                  icon: Icons.public,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: "Draft",
                  value: provider.draftCount.toString(),
                  color: Colors.orange,
                  icon: Icons.edit_document,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: "Archived",
                  value: provider.archivedCount.toString(),
                  color: Colors.grey,
                  icon: Icons.archive,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: "Pinned",
                  value: provider.pinnedCount.toString(),
                  color: Colors.blue,
                  icon: Icons.push_pin,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: "Total Notices",
                  value: provider.totalNotices.toString(),
                  color: Colors.red,
                  icon: Icons.campaign_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

         
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _MetricCard({
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
          Icon(icon, color: color),
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
          Text(title),
        ],
      ),
    );
  }
}