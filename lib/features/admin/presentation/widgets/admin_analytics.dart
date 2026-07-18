import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/admin_provider.dart';

class AdminAnalytics extends StatelessWidget {
  const AdminAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Analytics Overview",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),

        const SizedBox(height: 18),

        _progressCard(
          title: "Attendance Rate",
          value: "${provider.attendanceRate.toStringAsFixed(0)}%",
          progress: provider.attendanceRate / 100,
          color: const Color(0xff10B981),
        ),

        const SizedBox(height: 16),

        _progressCard(
          title: "Fee Collection",
          value: "${provider.attendanceRate.toStringAsFixed(0)}%",
          progress: provider.attendanceRate / 100,
          color: const Color(0xff2563EB),
        ),

        const SizedBox(height: 16),

        _progressCard(
          title: "Course Completion",
          value: "${provider.attendanceRate.toStringAsFixed(0)}%",
          progress: provider.attendanceRate / 100,
          color: const Color(0xffF59E0B),
        ),

        const SizedBox(height: 16),

        _progressCard(
          title: "Result Published",
          value: "${provider.attendanceRate.toStringAsFixed(0)}%",
          progress: provider.attendanceRate / 100,
          color: const Color(0xff8B5CF6),
        ),

      ],
    );
  }

  Widget _progressCard({
    required String title,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: Colors.grey.shade100,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

            ],
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation(color),
            ),
          ),

        ],
      ),
    );
  }
}