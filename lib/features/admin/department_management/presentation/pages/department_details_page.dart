import 'package:flutter/material.dart';

import '../../data/models/department_model.dart';

class DepartmentDetailsPage extends StatelessWidget {
  final DepartmentModel department;

  const DepartmentDetailsPage({
    super.key,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Department Details"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Card(
            elevation: 1,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                children: [

                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.orange.shade100,

                    child: const Icon(
                      Icons.account_tree,
                      size: 45,
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    department.departmentName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    department.departmentCode,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: department.status ==
                              DepartmentStatus.active
                          ? Colors.green.shade100
                          : Colors.red.shade100,

                      borderRadius:
                          BorderRadius.circular(25),
                    ),

                    child: Text(
                      department.status ==
                              DepartmentStatus.active
                          ? "Active"
                          : "Inactive",

                      style: TextStyle(
                        color: department.status ==
                                DepartmentStatus.active
                            ? Colors.green
                            : Colors.red,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          _SectionTitle("Department Information"),

          _InfoTile(
            "Department Name",
            department.departmentName,
          ),

          _InfoTile(
            "Department Code",
            department.departmentCode,
          ),

          _InfoTile(
            "Head of Department",
            department.headOfDepartment,
          ),

          _InfoTile(
            "Description",
            department.description,
          ),

          const SizedBox(height: 24),

          _SectionTitle("Office Information"),

          _InfoTile(
            "Office",
            department.officeLocation,
          ),

          _InfoTile(
            "Phone",
            department.phone,
          ),

          _InfoTile(
            "Email",
            department.email,
          ),

          const SizedBox(height: 24),

          _SectionTitle("Statistics"),

          Row(
            children: [

              Expanded(
                child: _StatCard(
                  "Faculty",
                  department.facultyCount.toString(),
                  Icons.person,
                  Colors.blue,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _StatCard(
                  "Students",
                  department.studentCount.toString(),
                  Icons.groups,
                  Colors.green,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          _StatCard(
            "Courses",
            department.courseCount.toString(),
            Icons.menu_book,
            Colors.orange,
          ),

          const SizedBox(height: 40),

        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile(
    this.title,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        title: Text(title),

        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
    this.title,
    this.value,
    this.icon,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          children: [

            CircleAvatar(
              backgroundColor:
                  color.withOpacity(.12),

              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 4),

            Text(title),

          ],
        ),
      ),
    );
  }
}