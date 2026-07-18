import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/lecturer_model.dart';
import '../provider/lecturer_management_provider.dart';
import '../../data/models/teaching_assignment.dart';

class AddEditLecturerPage extends StatefulWidget {
  final LecturerModel? lecturer;

  const AddEditLecturerPage({
    super.key,
    this.lecturer,
  });

  @override
  State<AddEditLecturerPage> createState() =>
      _AddEditLecturerPageState();
}

class _AddEditLecturerPageState
    extends State<AddEditLecturerPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController employeeIdController;
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cnicController;
  late TextEditingController dobController;

  late TextEditingController qualificationController;
  late TextEditingController specializationController;
  late TextEditingController officeLocationController;
  late TextEditingController joiningDateController;
  late TextEditingController addressController;

  LecturerGender selectedGender =
      LecturerGender.male;

  String selectedDepartment =
      "BS Computer Science";

  LecturerDesignation selectedDesignation =
      LecturerDesignation.lecturer;

  List<String> selectedCourses = [];

  List<String> selectedSections = [];

  @override
  void initState() {
    super.initState();

    final lecturer = widget.lecturer;

    employeeIdController = TextEditingController(
      text: lecturer?.employeeId ?? "",
    );

    fullNameController = TextEditingController(
      text: lecturer?.fullName ?? "",
    );

    emailController = TextEditingController(
      text: lecturer?.email ?? "",
    );

    phoneController = TextEditingController(
      text: lecturer?.phone ?? "",
    );

    cnicController = TextEditingController(
      text: lecturer?.cnic ?? "",
    );

    dobController = TextEditingController(
      text: lecturer?.dateOfBirth ?? "",
    );

    qualificationController =
        TextEditingController(
      text: lecturer?.qualification ?? "",
    );

    specializationController =
        TextEditingController(
      text: lecturer?.specialization ?? "",
    );

    officeLocationController =
        TextEditingController(
      text: lecturer?.officeLocation ?? "",
    );

    joiningDateController =
        TextEditingController(
      text: lecturer?.joiningDate ?? "",
    );

    addressController =
        TextEditingController(
      text: lecturer?.address ?? "",
    );

    if (lecturer != null) {
      selectedGender = lecturer.gender;

      selectedDepartment =
          lecturer.department;

      selectedDesignation =
          lecturer.designation;

    selectedCourses = lecturer.teachingAssignments
    .map((e) => e.course)
    .toSet()
    .toList();

selectedSections = lecturer.teachingAssignments
    .map((e) => e.section)
    .toSet()
    .toList();
    }
  }

  @override
  void dispose() {
    employeeIdController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cnicController.dispose();
    dobController.dispose();

    qualificationController.dispose();
    specializationController.dispose();
    officeLocationController.dispose();
    joiningDateController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.read<LecturerManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lecturer == null
              ? "Add Lecturer"
              : "Edit Lecturer",
        ),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
                        const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: employeeIdController,
              decoration: const InputDecoration(
                labelText: "Employee ID",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: cnicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CNIC",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<LecturerGender>(
              value: selectedGender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: LecturerGender.values.map(
                (gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(
                      gender.name[0].toUpperCase() +
                          gender.name.substring(1),
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: dobController,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                hintText: "DD/MM/YYYY",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 24),

            const Text(
              "Academic Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedDepartment,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
              items: const [

                DropdownMenuItem(
                  value: "BS Computer Science",
                  child: Text("BS Computer Science"),
                ),

                DropdownMenuItem(
                  value:
                      "BS Software Engineering",
                  child: Text(
                    "BS Software Engineering",
                  ),
                ),

                DropdownMenuItem(
                  value:
                      "BS Artificial Intelligence",
                  child: Text(
                    "BS Artificial Intelligence",
                  ),
                ),

                DropdownMenuItem(
                  value:
                      "BS Information Technology",
                  child: Text(
                    "BS Information Technology",
                  ),
                ),

              ],
              onChanged: (value) {
                setState(() {
                  selectedDepartment = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            DropdownButtonFormField<
                LecturerDesignation>(
              value: selectedDesignation,
              decoration: const InputDecoration(
                labelText: "Designation",
                border: OutlineInputBorder(),
              ),
              items: LecturerDesignation.values
                  .map(
                    (designation) =>
                        DropdownMenuItem(
                      value: designation,
                      child: Text(
                        designation.name
                            .replaceAllMapped(
                          RegExp(r'([A-Z])'),
                          (match) =>
                              ' ${match.group(1)}',
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDesignation = value!;
                });
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller:
                  qualificationController,
              decoration: const InputDecoration(
                labelText: "Qualification",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller:
                  specializationController,
              decoration: const InputDecoration(
                labelText: "Specialization",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 24),
                        const Text(
              "Office Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: officeLocationController,
              decoration: const InputDecoration(
                labelText: "Office Location",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: joiningDateController,
              decoration: const InputDecoration(
                labelText: "Joining Date",
                hintText: "DD/MM/YYYY",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 24),

            const Text(
              "Assigned Courses",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                "Programming Fundamentals",
                "Object Oriented Programming",
                "Data Structures",
                "Database Systems",
                "Operating Systems",
                "Computer Networks",
              ].map((course) {
                final selected =
                    selectedCourses.contains(course);

                return FilterChip(
                  label: Text(course),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedCourses.add(course);
                      } else {
                        selectedCourses.remove(course);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            const Divider(),

            const SizedBox(height: 24),

            const Text(
              "Assigned Sections",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
  // =========================
  // BS Computer Science
  // =========================

  "BSCS-1A",
  "BSCS-1B",
  "BSCS-1C",
  "BSCS-1D",
  "BSCS-1E",
  "BSCS-1F",

  "BSCS-2A",
  "BSCS-2B",
  "BSCS-2C",
  "BSCS-2D",
  "BSCS-2E",
  "BSCS-2F",

  "BSCS-3A",
  "BSCS-3B",
  "BSCS-3C",
  "BSCS-3D",
  "BSCS-3E",
  "BSCS-3F",

  "BSCS-4A",
  "BSCS-4B",
  "BSCS-4C",
  "BSCS-4D",
  "BSCS-4E",
  "BSCS-4F",

  "BSCS-5A",
  "BSCS-5B",
  "BSCS-5C",
  "BSCS-5D",
  "BSCS-5E",
  "BSCS-5F",

  "BSCS-6A",
  "BSCS-6B",
  "BSCS-6C",
  "BSCS-6D",
  "BSCS-6E",
  "BSCS-6F",

  "BSCS-7A",
  "BSCS-7B",
  "BSCS-7C",
  "BSCS-7D",
  "BSCS-7E",
  "BSCS-7F",

  "BSCS-8A",
  "BSCS-8B",
  "BSCS-8C",
  "BSCS-8D",
  "BSCS-8E",
  "BSCS-8F",

  // =========================
  // BS Software Engineering
  // =========================

  "BSSE-1A",
  "BSSE-1B",

  "BSSE-2A",
  "BSSE-2B",

  "BSSE-3A",
  "BSSE-3B",

  "BSSE-4A",
  "BSSE-4B",

  "BSSE-5A",
  "BSSE-5B",

  "BSSE-6A",
  "BSSE-6B",

  "BSSE-7A",
  "BSSE-7B",

  "BSSE-8A",
  "BSSE-8B",

  // =========================
  // BS Artificial Intelligence
  // =========================

  "BSAI-1A",
  "BSAI-1B",

  "BSAI-2A",
  "BSAI-2B",

  "BSAI-3A",
  "BSAI-3B",

  "BSAI-4A",
  "BSAI-4B",

  "BSAI-5A",
  "BSAI-5B",

  "BSAI-6A",
  "BSAI-6B",

  "BSAI-7A",
  "BSAI-7B",

  "BSAI-8A",
  "BSAI-8B",
]
              .map((section) {
                final selected =
                    selectedSections.contains(section);

                return FilterChip(
                  label: Text(section),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedSections.add(section);
                      } else {
                        selectedSections.remove(section);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 36),

            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

  if (!_formKey.currentState!.validate()) {
    return;
  }

  final lecturer = LecturerModel(
    id: widget.lecturer?.id ??
        DateTime.now().millisecondsSinceEpoch.toString(),

    employeeId: employeeIdController.text.trim(),

    fullName: fullNameController.text.trim(),

    email: emailController.text.trim(),

    phone: phoneController.text.trim(),

    cnic: cnicController.text.trim(),

    gender: selectedGender,

    dateOfBirth: dobController.text.trim(),

    department: selectedDepartment,

    designation: selectedDesignation,

    qualification:
        qualificationController.text.trim(),

    specialization:
        specializationController.text.trim(),

    officeLocation:
        officeLocationController.text.trim(),

    joiningDate:
        joiningDateController.text.trim(),

    address: addressController.text.trim(),

     profileImage:
      "assets/images/${emailController.text.trim().split('@').first.toLowerCase()}.png",

   teachingAssignments: [
  for (final course in selectedCourses)
    for (final section in selectedSections)
      TeachingAssignment(
        course: course,
        section: section,
      ),
],

    status: widget.lecturer?.status ??
        LecturerStatus.active,
  );

  try {

    if (widget.lecturer == null) {

      final password =
          await provider.addLecturer(lecturer);

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text(
            "Lecturer Created",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              const Text(
                "Save these credentials.",
              ),

              const SizedBox(height: 20),

              SelectableText(
                "Email:\n${lecturer.email}",
              ),

              const SizedBox(height: 15),

              SelectableText(
                "Temporary Password:\n$password",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Share this password with the lecturer.",
              ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );

    } else {

      await provider.updateLecturer(
        lecturer,
      );

    }

    if (!mounted) return;

    Navigator.pop(context);

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),

    );

  }

},
                child: Text(
                  widget.lecturer == null
                      ? "Add Lecturer"
                      : "Update Lecturer",
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}