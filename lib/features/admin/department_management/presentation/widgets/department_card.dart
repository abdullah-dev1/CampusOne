import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/department_model.dart';
import '../dialogs/department_dialog.dart';
import '../provider/department_management_provider.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentModel department;

  const DepartmentCard({
    super.key,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DepartmentManagementProvider>();

    final bool isActive = department.status == DepartmentStatus.active;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff7C3AED).withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------- HEADER ----------------//
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff7C3AED),
                        Color(0xff5B21B6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      department.name.isNotEmpty
                          ? department.name[0].toUpperCase()
                          : "D",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        department.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _MiniChip(
                            icon: Icons.badge_outlined,
                            label: department.code,
                            color: const Color(0xff7C3AED),
                          ),
                          _MiniChip(
                            icon: Icons.email_outlined,
                            label: department.email.isEmpty
                                ? "No email"
                                : department.email,
                            color: Colors.grey.shade600,
                            background: Colors.grey.shade100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xff22C55E).withOpacity(.12)
                        : const Color(0xffEF4444).withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        size: 13,
                        color: isActive
                            ? const Color(0xff16A34A)
                            : const Color(0xffDC2626),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isActive ? "Active" : "Inactive",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isActive
                              ? const Color(0xff16A34A)
                              : const Color(0xffDC2626),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            //---------------- DETAILS ----------------//
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.person_outline_rounded,
                    label: "Head of Department",
                    value: department.hodName.isEmpty
                        ? "Not Assigned"
                        : department.hodName,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.phone_outlined,
                    label: "Phone",
                    value: department.phone.isEmpty
                        ? "Not Available"
                        : department.phone,
                  ),
                ),
              ],
            ),

            if (department.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                department.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],

            const SizedBox(height: 14),

            //---------------- BUTTONS ----------------//
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text(
                        "Edit",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xff7C3AED),
                        side: const BorderSide(
                          color: Color(0xff7C3AED),
                          width: 1.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                              value: provider,
                              child: DepartmentDialog(department: department),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        isActive ? Icons.block : Icons.check_circle,
                        size: 16,
                      ),
                      label: Text(
                        isActive ? "Deactivate" : "Activate",
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isActive
                            ? const Color(0xffFEE2E2)
                            : const Color(0xffDCFCE7),
                        foregroundColor: isActive
                            ? const Color(0xffDC2626)
                            : const Color(0xff16A34A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await provider.updateDepartment(
                          department.copyWith(
                            status: isActive
                                ? DepartmentStatus.inactive
                                : DepartmentStatus.active,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xffFEE2E2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xffDC2626),
                      size: 18,
                    ),
                    onPressed: () async {
                      await provider.deleteDepartment(department.id);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? background;

  const _MiniChip({
    required this.icon,
    required this.label,
    required this.color,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background ?? color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 130),
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.grey.shade500),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xff0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}