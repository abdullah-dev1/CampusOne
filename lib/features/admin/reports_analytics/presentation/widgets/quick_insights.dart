import 'package:flutter/material.dart';

class QuickInsights extends StatelessWidget {
  const QuickInsights({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const Text(
          "Quick Insights",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        _InsightCard(
          icon: Icons.apartment_rounded,
          color: Colors.blue,
          title: "Largest Department",
          value: "Computer Science",
          subtitle:
              "548 enrolled students",
        ),

        const SizedBox(height: 14),

        _InsightCard(
          icon: Icons.menu_book_rounded,
          color: Colors.orange,
          title: "Department With Most Courses",
          value: "Software Engineering",
          subtitle:
              "34 active courses",
        ),

        const SizedBox(height: 14),

        _InsightCard(
          icon: Icons.campaign_rounded,
          color: Colors.red,
          title: "Latest Notice",
          value:
              "Mid-Term Examination Schedule",
          subtitle:
              "Published 2 hours ago",
        ),

        const SizedBox(height: 14),

        _InsightCard(
          icon: Icons.groups_rounded,
          color: Colors.green,
          title: "Average Students",
          value:
              "156 Students / Department",
          subtitle:
              "Calculated automatically",
        ),

        const SizedBox(height: 14),

        _InsightCard(
          icon: Icons.analytics_rounded,
          color: Colors.deepPurple,
          title: "Average Courses",
          value:
              "17 Courses / Department",
          subtitle:
              "Based on active courses",
        ),

      ],
    );
  }
}

class _InsightCard extends StatelessWidget {

  final IconData icon;
  final Color color;

  final String title;
  final String value;
  final String subtitle;

  const _InsightCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),

        ],
      ),

      child: Row(
        children: [

          Container(
            height: 58,
            width: 58,

            decoration: BoxDecoration(
              color: color.withOpacity(.12),

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,

                  style: TextStyle(
                    color:
                        Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}