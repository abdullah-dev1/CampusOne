import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/department_model.dart';
import '../provider/department_management_provider.dart';

class DepartmentDialog extends StatefulWidget {
  final DepartmentModel? department;

  const DepartmentDialog({
    super.key,
    this.department,
  });

  @override
  State<DepartmentDialog> createState() =>
      _DepartmentDialogState();
}

class _DepartmentDialogState
    extends State<DepartmentDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _hodController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _descriptionController;

  late DepartmentStatus _status;

  bool get isEdit =>
      widget.department != null;

  @override
  void initState() {
    super.initState();

    final department = widget.department;

    _nameController = TextEditingController(
      text: department?.name ?? "",
    );

    _codeController = TextEditingController(
      text: department?.code ?? "",
    );

    _hodController = TextEditingController(
      text: department?.hodName ?? "",
    );

    _emailController = TextEditingController(
      text: department?.email ?? "",
    );

    _phoneController = TextEditingController(
      text: department?.phone ?? "",
    );

    _descriptionController =
        TextEditingController(
      text: department?.description ?? "",
    );

    _status =
        department?.status ??
            DepartmentStatus.active;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _hodController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration decoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider =
        context.read<
            DepartmentManagementProvider>();

    final department = DepartmentModel(
      id: widget.department?.id ?? "",
      name: _nameController.text.trim(),
      code: _codeController.text.trim(),
      hodName: _hodController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      description:
          _descriptionController.text.trim(),
      status: _status,
      createdAt:
          widget.department?.createdAt ??
              DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (isEdit) {
      await provider.updateDepartment(
        department,
      );
    } else {
      await provider.addDepartment(
        department,
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        isEdit
            ? "Edit Department"
            : "Add Department",
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [

                TextFormField(
                  controller:
                      _nameController,
                  decoration:
                      decoration(
                    "Department Name",
                    Icons.business,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      _codeController,
                  decoration:
                      decoration(
                    "Department Code",
                    Icons.code,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      _hodController,
                  decoration:
                      decoration(
                    "HOD Name",
                    Icons.person,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      _emailController,
                  decoration:
                      decoration(
                    "Email",
                    Icons.email,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      _phoneController,
                  decoration:
                      decoration(
                    "Phone",
                    Icons.phone,
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller:
                      _descriptionController,
                  maxLines: 3,
                  decoration:
                      decoration(
                    "Description",
                    Icons.description,
                  ),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<
                    DepartmentStatus>(
                  value: _status,
                  decoration:
                      decoration(
                    "Status",
                    Icons.check_circle,
                  ),
                  items:
                      DepartmentStatus.values
                          .map(
                            (status) =>
                                DropdownMenuItem(
                              value: status,
                              child: Text(
                                status.name,
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _status = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [

        TextButton(
          onPressed: () =>
              Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: _save,
          child: Text(
            isEdit
                ? "Update"
                : "Save",
          ),
        ),
      ],
    );
  }
}