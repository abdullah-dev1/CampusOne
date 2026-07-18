import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';
import '../provider/notice_management_provider.dart';

class NoticeStatistics extends StatelessWidget {
  const NoticeStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeManagementProvider>(
      builder: (context, provider, child) {
        final notices = provider.notices;

        final total = notices.length;

        final published = notices
            .where(
              (e) => e.status == NoticeStatus.published,
            )
            .length;

        final draft = notices
            .where(
              (e) => e.status == NoticeStatus.draft,
            )
            .length;

        final pinned = notices
            .where(
              (e) => e.isPinned,
            )
            .length;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,

          childAspectRatio: 1.22,

          children: [

            _StatCard(
              title: "Total",
              value: total.toString(),
              icon: Icons.campaign_rounded,
              color: const Color(0xff2563EB),
            ),

            _StatCard(
              title: "Published",
              value: published.toString(),
              icon: Icons.public,
              color: const Color(0xff059669),
            ),

            _StatCard(
              title: "Draft",
              value: draft.toString(),
              icon: Icons.edit_document,
              color: const Color(0xffF59E0B),
            ),

            _StatCard(
              title: "Pinned",
              value: pinned.toString(),
              icon: Icons.push_pin,
              color: const Color(0xffDC2626),
            ),

          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),

        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            height: 42,
            width: 42,

            decoration: BoxDecoration(
              color: color.withOpacity(.12),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
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