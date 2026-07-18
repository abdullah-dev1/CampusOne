import 'package:flutter/material.dart';

import '../../data/models/dashboard_card_model.dart';

class DashboardCard extends StatelessWidget {
  final DashboardCardModel card;

  const DashboardCard({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CircleAvatar(
                radius: 26,
                backgroundColor: card.color.withOpacity(.15),
                child: Icon(
                  card.icon,
                  color: card.color,
                ),
              ),

              const Spacer(),

              Text(
                card.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                card.subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}