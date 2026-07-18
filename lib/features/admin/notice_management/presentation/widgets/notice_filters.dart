import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notice_management_provider.dart';

class NoticeFilters extends StatelessWidget {
  const NoticeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<NoticeManagementProvider>();

    return Column(
      children: [

        TextField(
          decoration: InputDecoration(
            hintText: "Search notices...",

            prefixIcon: const Icon(Icons.search),

            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),

          onChanged: provider.searchNotices,
        ),

        const SizedBox(height: 18),

        Row(
          children: [

            Expanded(
              child: DropdownButtonFormField<String>(
                value: provider.selectedCategory,

                decoration: InputDecoration(
                  labelText: "Category",

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "All",
                    child: Text("All"),
                  ),

                  DropdownMenuItem(
                    value: "Academic",
                    child: Text("Academic"),
                  ),

                  DropdownMenuItem(
                    value: "Examination",
                    child: Text("Examination"),
                  ),

                  DropdownMenuItem(
                    value: "Admission",
                    child: Text("Admission"),
                  ),

                  DropdownMenuItem(
                    value: "Events",
                    child: Text("Events"),
                  ),

                  DropdownMenuItem(
                    value: "Scholarship",
                    child: Text("Scholarship"),
                  ),

                  DropdownMenuItem(
                    value: "Hostel",
                    child: Text("Hostel"),
                  ),

                  DropdownMenuItem(
                    value: "Sports",
                    child: Text("Sports"),
                  ),

                  DropdownMenuItem(
                    value: "Holiday",
                    child: Text("Holiday"),
                  ),

                  DropdownMenuItem(
                    value: "Emergency",
                    child: Text("Emergency"),
                  ),

                  DropdownMenuItem(
                    value: "General",
                    child: Text("General"),
                  ),

                ],

                onChanged: (value) {
                  provider.filterCategory(
                    value!,
                  );
                },
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: DropdownButtonFormField<String>(
                value: provider.selectedStatus,

                decoration: InputDecoration(
                  labelText: "Status",

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "All",
                    child: Text("All"),
                  ),

                  DropdownMenuItem(
                    value: "Published",
                    child: Text("Published"),
                  ),

                  DropdownMenuItem(
                    value: "Draft",
                    child: Text("Draft"),
                  ),

                  DropdownMenuItem(
                    value: "Archived",
                    child: Text("Archived"),
                  ),

                ],

                onChanged: (value) {
                  provider.filterStatus(
                    value!,
                  );
                },
              ),
            ),

          ],
        ),

      ],
    );
  }
}