import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/department_management_provider.dart';
import 'department_card.dart';

class DepartmentList extends StatelessWidget {
  const DepartmentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DepartmentManagementProvider>();

    if (provider.isLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xff7C3AED),
            strokeWidth: 3,
          ),
        ),
      );
    }

    final departments = provider.filteredDepartments;

    if (departments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 84,
              width: 84,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff7C3AED).withOpacity(.14),
                    const Color(0xff7C3AED).withOpacity(.06),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.business_outlined,
                size: 40,
                color: Color(0xff7C3AED),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "No Departments Found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xff0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your filters or add a new department.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: departments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, index) {
        return DepartmentCard(
          department: departments[index],
        );
      },
    );
  }
}