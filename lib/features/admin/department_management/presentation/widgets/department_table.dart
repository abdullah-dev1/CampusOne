import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/department_model.dart';
import '../dialogs/department_dialog.dart';
import '../provider/department_management_provider.dart';

class DepartmentTable extends StatelessWidget {
  const DepartmentTable({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<DepartmentManagementProvider>();

    final departments =
        provider.filteredDepartments;

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (departments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "No Departments Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
  columnSpacing: 28,
  headingRowHeight: 56,
  dataRowMinHeight: 56,
  dataRowMaxHeight: 56,
  showCheckboxColumn: true,

          columns: const [

            DataColumn(
              label: Text("Department"),
            ),

            DataColumn(
              label: Text("Code"),
            ),

            DataColumn(
              label: Text("HOD"),
            ),

            DataColumn(
              label: Text("Email"),
            ),

            DataColumn(
              label: Text("Phone"),
            ),

            DataColumn(
              label: Text("Status"),
            ),

            DataColumn(
              label: Text("Actions"),
            ),
          ],

          rows:
              departments.map((department) {
            return DataRow(

              selected: provider.isSelected(
                department.id,
              ),

              onSelectChanged: (_) {
                provider.toggleSelection(
                  department.id,
                );
              },

              cells: [

                DataCell(
                  Text(department.name),
                ),

                DataCell(
                  Text(department.code),
                ),

                DataCell(
                  Text(
                    department.hodName,
                  ),
                ),

                DataCell(
                  Text(
                    department.email,
                  ),
                ),

                DataCell(
                  Text(
                    department.phone,
                  ),
                ),

                DataCell(
                  Chip(
                    backgroundColor:
                        department.status ==
                                DepartmentStatus
                                    .active
                            ? Colors.green
                                .shade100
                            : Colors.red
                                .shade100,
                    label: Text(
                      department.status
                          .name
                          .toUpperCase(),
                      style:
                          TextStyle(
                        color:
                            department.status ==
                                    DepartmentStatus
                                        .active
                                ? Colors.green
                                : Colors.red,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                DataCell(
                  Row(
                    children: [

                      IconButton(
                        tooltip:
                            "Edit",
                        icon: const Icon(
                          Icons.edit,
                          color:
                              Colors.blue,
                        ),
                        onPressed: () {
                          showDialog(
  context: context,
  builder: (dialogContext) {
    return ChangeNotifierProvider.value(
      value: context.read<DepartmentManagementProvider>(),
      child: DepartmentDialog(
        department: department,
      ),
    );
  },
);
                        },
                      ),

                      IconButton(
                        tooltip:
                            "Delete",
                        icon: const Icon(
                          Icons.delete,
                          color:
                              Colors.red,
                        ),
                        onPressed: () async {

                          final confirm =
                              await showDialog<
                                  bool>(
                            context:
                                context,
                            builder:
                                (_) =>
                                    AlertDialog(
                              title:
                                  const Text(
                                "Delete Department",
                              ),
                              content:
                                  Text(
                                "Delete ${department.name}?",
                              ),
                              actions: [

                                TextButton(
                                  onPressed:
                                      () =>
                                          Navigator.pop(
                                    context,
                                    false,
                                  ),
                                  child:
                                      const Text(
                                    "Cancel",
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed:
                                      () =>
                                          Navigator.pop(
                                    context,
                                    true,
                                  ),
                                  child:
                                      const Text(
                                    "Delete",
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm ==
                              true) {
                            provider
                                .deleteDepartment(
                              department.id,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}