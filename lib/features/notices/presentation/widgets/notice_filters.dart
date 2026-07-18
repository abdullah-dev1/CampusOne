import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notice_provider.dart';

class NoticeFilters extends StatelessWidget {
  const NoticeFilters({super.key});

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<NoticeProvider>();

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [

          TextField(
            decoration: InputDecoration(
              hintText: "Search Notice",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),

            onChanged:
                provider.searchNotice,
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<String>(
            value: provider.selectedPriority,

            decoration: InputDecoration(
              labelText: "Priority",

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),
            ),

            items: const [

              DropdownMenuItem(
                value: "All",
                child: Text("All"),
              ),

              DropdownMenuItem(
                value: "high",
                child: Text("High"),
              ),

              DropdownMenuItem(
                value: "medium",
                child: Text("Medium"),
              ),

              DropdownMenuItem(
                value: "low",
                child: Text("Low"),
              ),

            ],

            onChanged: (value) {

              if (value != null) {
                provider.changePriority(value);
              }

            },
          ),

        ],
      ),
    );
  }
}