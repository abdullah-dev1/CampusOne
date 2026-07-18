import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/department_model.dart';
import '../provider/department_management_provider.dart';

class AddEditDepartmentPage extends StatefulWidget {
  final DepartmentModel? department;

  const AddEditDepartmentPage({
    super.key,
    this.department,
  });

  @override
  State<AddEditDepartmentPage> createState() =>
      _AddEditDepartmentPageState();
}

class _AddEditDepartmentPageState
    extends State<AddEditDepartmentPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController hodController;
  late TextEditingController officeController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController facultyController;
  late TextEditingController studentController;
  late TextEditingController courseController;

  @override
  void initState() {
    super.initState();

    final department = widget.department;

    codeController = TextEditingController(
      text: department?.departmentCode ?? "",
    );

    nameController = TextEditingController(
      text: department?.departmentName ?? "",
    );

    descriptionController = TextEditingController(
      text: department?.description ?? "",
    );

    hodController = TextEditingController(
      text: department?.headOfDepartment ?? "",
    );

    officeController = TextEditingController(
      text: department?.officeLocation ?? "",
    );

    phoneController = TextEditingController(
      text: department?.phone ?? "",
    );

    emailController = TextEditingController(
      text: department?.email ?? "",
    );

    facultyController = TextEditingController(
      text: department?.facultyCount.toString() ?? "0",
    );

    studentController = TextEditingController(
      text: department?.studentCount.toString() ?? "0",
    );

    courseController = TextEditingController(
      text: department?.courseCount.toString() ?? "0",
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    hodController.dispose();
    officeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    facultyController.dispose();
    studentController.dispose();
    courseController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.read<DepartmentManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.department == null
              ? "Add Department"
              : "Edit Department",
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [

            _field(
              codeController,
              "Department Code",
            ),

            const SizedBox(height: 18),

            _field(
              nameController,
              "Department Name",
            ),

            const SizedBox(height: 18),

            _field(
              hodController,
              "Head of Department",
            ),

            const SizedBox(height: 18),

            _field(
              descriptionController,
              "Description",
              maxLines: 3,
            ),

            const SizedBox(height: 18),

            _field(
              officeController,
              "Office Location",
            ),

            const SizedBox(height: 18),

            _field(
              phoneController,
              "Phone",
            ),

            const SizedBox(height: 18),

            _field(
              emailController,
              "Email",
            ),

            const SizedBox(height: 18),

            Row(
              children: [

                Expanded(
                  child: _field(
                    facultyController,
                    "Faculty",
                    number: true,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _field(
                    studentController,
                    "Students",
                    number: true,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18),

            _field(
              courseController,
              "Courses",
              number: true,
            ),

            const SizedBox(height: 35),

            SizedBox(
              height: 55,

              child: ElevatedButton(
                onPressed: () {

                  if (!_formKey.currentState!
                      .validate()) {
                    return;
                  }

                  final department = DepartmentModel(
                    id: widget.department?.id ??
                        DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(),

                    departmentCode:
                        codeController.text,

                    departmentName:
                        nameController.text,

                    description:
                        descriptionController.text,

                    headOfDepartment:
                        hodController.text,

                    facultyCount:
                        int.tryParse(
                              facultyController.text,
                            ) ??
                            0,

                    studentCount:
                        int.tryParse(
                              studentController.text,
                            ) ??
                            0,

                    courseCount:
                        int.tryParse(
                              courseController.text,
                            ) ??
                            0,

                    officeLocation:
                        officeController.text,

                    phone:
                        phoneController.text,

                    email:
                        emailController.text,

                    status:
                        widget.department?.status ??
                            DepartmentStatus.active,
                  );

                  if (widget.department ==
                      null) {
                    provider.addDepartment(
                      department,
                    );
                  } else {
                    provider.updateDepartment(
                      department,
                    );
                  }

                  Navigator.pop(context);
                },

                child: Text(
                  widget.department == null
                      ? "Add Department"
                      : "Update Department",
                ),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool number = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,

      keyboardType: number
          ? TextInputType.number
          : TextInputType.text,

      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),

      validator: (value) {
        if (value == null ||
            value.trim().isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}