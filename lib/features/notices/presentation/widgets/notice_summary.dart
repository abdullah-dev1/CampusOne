import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notice_provider.dart';

class NoticeSummary extends StatelessWidget {
  const NoticeSummary({super.key});

  Widget summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(18),
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
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<NoticeProvider>();

    return Row(
      children: [

        summaryCard(
          "Total",
          provider.totalNotices.toString(),
          Icons.article,
          Colors.blue,
        ),

        const SizedBox(width: 12),

        summaryCard(
          "Pinned",
          provider.pinnedNotices.toString(),
          Icons.push_pin,
          Colors.orange,
        ),

        const SizedBox(width: 12),

        summaryCard(
          "Published",
          provider.publishedNotices.toString(),
          Icons.public,
          Colors.green,
        ),

      ],
    );
  }
}