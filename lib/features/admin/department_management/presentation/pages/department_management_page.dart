import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/repository/department_repository.dart';
import '../../../../../core/services/service_locator.dart';
import '../dialogs/department_dialog.dart';
import '../provider/department_management_provider.dart';
import '../widgets/department_dashboard_cards.dart';
import '../widgets/department_filters.dart';
import '../widgets/department_list.dart';

class DepartmentManagementPage extends StatelessWidget {
  const DepartmentManagementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DepartmentManagementProvider(
        locator<DepartmentRepository>(),
      ),
      child: Consumer<DepartmentManagementProvider>(
        builder: (context, provider, _) {
          final screenWidth = MediaQuery.of(context).size.width;
          final horizontalPadding = screenWidth > 700 ? 24.0 : 16.0;

          return Scaffold(
            backgroundColor: const Color(0xffF8FAFC),
            appBar: AppBar(
              title: const Text(
                "Department Management",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Color(0xff0F172A),
                ),
              ),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: const Color(0xff7C3AED),
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                "Add Department",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return ChangeNotifierProvider.value(
                      value: context.read<DepartmentManagementProvider>(),
                      child: const DepartmentDialog(),
                    );
                  },
                );
              },
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department Management",
                    style: TextStyle(
                      fontSize: screenWidth > 700 ? 28 : 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xff0F172A),
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Manage all university departments",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const DepartmentDashboardCards(),

                  const SizedBox(height: 22),

                  const DepartmentFilters(),

                  const SizedBox(height: 22),

                  if (provider.hasSelection)
                    Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff7C3AED).withOpacity(.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xff7C3AED).withOpacity(.15),
                        ),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Text(
                            "${provider.selectedCount} Selected",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff0F172A),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: provider.clearSelection,
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            label: const Text("Clear"),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffEF4444),
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                            onPressed: () {
                              provider.deleteSelectedDepartments();
                            },
                            icon: const Icon(Icons.delete_outline_rounded, size: 18),
                            label: const Text("Delete"),
                          ),
                        ],
                      ),
                    ),

                  const DepartmentList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}