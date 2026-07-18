import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_management_provider.dart';

class DepartmentFilters extends StatelessWidget {
  const DepartmentFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentManagementProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search Department",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: provider.searchDepartments,
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              value: provider.selectedStatus,
              decoration: InputDecoration(
                labelText: "Status",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                DropdownMenuItem(
                  value: "Active",
                  child: Text("Active"),
                ),
                DropdownMenuItem(
                  value: "Inactive",
                  child: Text("Inactive"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  provider.filterStatus(value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}