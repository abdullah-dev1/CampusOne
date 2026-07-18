import 'package:flutter/material.dart';

class AdminSystemOverview extends StatelessWidget {
  const AdminSystemOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "System Overview",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0F172A),
          ),
        ),

        const SizedBox(height: 18),

        Row(
          children: [

            Expanded(
              child: _statusCard(
                title: "Server",
                value: "Online",
                color: Colors.green,
                icon: Icons.cloud_done,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _statusCard(
                title: "Database",
                value: "Healthy",
                color: Colors.blue,
                icon: Icons.storage,
              ),
            ),

          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [

            Expanded(
              child: _statusCard(
                title: "Users Online",
                value: "247",
                color: Colors.orange,
                icon: Icons.people,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: _statusCard(
                title: "Storage",
                value: "68%",
                color: Colors.purple,
                icon: Icons.sd_storage,
              ),
            ),

          ],
        ),
      ],
    );
  }

  Widget _statusCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
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
        children: [

          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 14),

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
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}