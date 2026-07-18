import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/student_model.dart';
import '../provider/student_management_provider.dart';

class AddEditStudentPage extends StatefulWidget {
  final StudentModel? student;

  const AddEditStudentPage({
    super.key,
    this.student,
  });

  @override
  State<AddEditStudentPage> createState() => _AddEditStudentPageState();
}

class _AddEditStudentPageState extends State<AddEditStudentPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController regController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cnicController;
  late TextEditingController dobController;
  late TextEditingController addressController;
  late TextEditingController guardianNameController;
  late TextEditingController guardianPhoneController;
  late TextEditingController cgpaController;

  String department = "BS Computer Science";
  String semester = "5";
  String section = "BSCS-5A";
  StudentGender selectedGender = StudentGender.male;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.student?.fullName ?? "");
    regController = TextEditingController(text: widget.student?.registrationNo ?? "");
    emailController = TextEditingController(text: widget.student?.email ?? "");
    phoneController = TextEditingController(text: widget.student?.phone ?? "");
    cnicController = TextEditingController(text: widget.student?.cnic ?? "");
    dobController = TextEditingController(text: widget.student?.dateOfBirth ?? "");
    addressController = TextEditingController(text: widget.student?.address ?? "");
    guardianNameController = TextEditingController(text: widget.student?.guardianName ?? "");
    guardianPhoneController = TextEditingController(text: widget.student?.guardianPhone ?? "");
    cgpaController = TextEditingController(text: widget.student?.cgpa.toString() ?? "0.0");

    if (widget.student != null) {
      department = widget.student!.department;
      semester = widget.student!.semester;
      section = widget.student!.section;
      selectedGender = widget.student!.gender;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    regController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cnicController.dispose();
    dobController.dispose();
    addressController.dispose();
    guardianNameController.dispose();
    guardianPhoneController.dispose();
    cgpaController.dispose();
    super.dispose();
  }

  Future<void> _showPasswordDialog(String password) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Student Account Created"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Share this password with the student:"),
            const SizedBox(height: 12),
            SelectableText(
              password,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "The student can change password with admin approval.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close form page
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final provider = context.read<StudentManagementProvider>();

    final student = StudentModel(
      id: widget.student?.id ?? "",
      registrationNo: regController.text,
      fullName: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      cnic: cnicController.text,
      gender: selectedGender,
      dateOfBirth: dobController.text,
      department: department,
      semester: semester,
      section: section,
      address: addressController.text,
      guardianName: guardianNameController.text,
      guardianPhone: guardianPhoneController.text,
      profileImage:
    "assets/images/${emailController.text.split('@').first.toLowerCase()}.png",
      cgpa: double.tryParse(cgpaController.text) ?? 0.0,
      status: widget.student?.status ?? StudentStatus.active,
    );

    try {
      if (widget.student == null) {
        final password = await provider.addStudent(student);
        if (!mounted) return;
        setState(() => isSaving = false);
        await _showPasswordDialog(password);
      } else {
        await provider.updateStudent(student);
        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? "Add Student" : "Edit Student"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: regController,
              decoration: const InputDecoration(
                labelText: "Registration No",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: emailController,
              enabled: widget.student == null, // email fixed after creation
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: cnicController,
              decoration: const InputDecoration(
                labelText: "CNIC",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<StudentGender>(
              value: selectedGender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: StudentGender.male, child: Text("Male")),
                DropdownMenuItem(value: StudentGender.female, child: Text("Female")),
              ],
              onChanged: (value) => setState(() => selectedGender = value!),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: dobController,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: department,
              decoration: const InputDecoration(
                labelText: "Department",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "BS Computer Science", child: Text("BS Computer Science")),
                DropdownMenuItem(value: "BS Software Engineering", child: Text("BS Software Engineering")),
                DropdownMenuItem(value: "BS Artificial Intelligence", child: Text("BS Artificial Intelligence")),
              ],
              onChanged: (value) => setState(() => department = value!),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: semester,
              decoration: const InputDecoration(
                labelText: "Semester",
                border: OutlineInputBorder(),
              ),
              items: List.generate(
                8,
                (index) => DropdownMenuItem(
                  value: "${index + 1}",
                  child: Text("Semester ${index + 1}"),
                ),
              ),
              onChanged: (value) => setState(() => semester = value!),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<String>(
              value: section,
              decoration: const InputDecoration(
                labelText: "Section",
                border: OutlineInputBorder(),
              ),
              items: const [

// ---------- BSCS ----------
DropdownMenuItem(value: "BSCS-1A", child: Text("BSCS-1A")),
DropdownMenuItem(value: "BSCS-1B", child: Text("BSCS-1B")),
DropdownMenuItem(value: "BSCS-1C", child: Text("BSCS-1C")),
DropdownMenuItem(value: "BSCS-1D", child: Text("BSCS-1D")),
DropdownMenuItem(value: "BSCS-1E", child: Text("BSCS-1E")),
DropdownMenuItem(value: "BSCS-1F", child: Text("BSCS-1F")),

DropdownMenuItem(value: "BSCS-2A", child: Text("BSCS-2A")),
DropdownMenuItem(value: "BSCS-2B", child: Text("BSCS-2B")),
DropdownMenuItem(value: "BSCS-2C", child: Text("BSCS-2C")),
DropdownMenuItem(value: "BSCS-2D", child: Text("BSCS-2D")),
DropdownMenuItem(value: "BSCS-2E", child: Text("BSCS-2E")),
DropdownMenuItem(value: "BSCS-2F", child: Text("BSCS-2F")),

DropdownMenuItem(value: "BSCS-3A", child: Text("BSCS-3A")),
DropdownMenuItem(value: "BSCS-3B", child: Text("BSCS-3B")),
DropdownMenuItem(value: "BSCS-3C", child: Text("BSCS-3C")),
DropdownMenuItem(value: "BSCS-3D", child: Text("BSCS-3D")),
DropdownMenuItem(value: "BSCS-3E", child: Text("BSCS-3E")),
DropdownMenuItem(value: "BSCS-3F", child: Text("BSCS-3F")),

DropdownMenuItem(value: "BSCS-4A", child: Text("BSCS-4A")),
DropdownMenuItem(value: "BSCS-4B", child: Text("BSCS-4B")),
DropdownMenuItem(value: "BSCS-4C", child: Text("BSCS-4C")),
DropdownMenuItem(value: "BSCS-4D", child: Text("BSCS-4D")),
DropdownMenuItem(value: "BSCS-4E", child: Text("BSCS-4E")),
DropdownMenuItem(value: "BSCS-4F", child: Text("BSCS-4F")),

DropdownMenuItem(value: "BSCS-5A", child: Text("BSCS-5A")),
DropdownMenuItem(value: "BSCS-5B", child: Text("BSCS-5B")),
DropdownMenuItem(value: "BSCS-5C", child: Text("BSCS-5C")),
DropdownMenuItem(value: "BSCS-5D", child: Text("BSCS-5D")),
DropdownMenuItem(value: "BSCS-5E", child: Text("BSCS-5E")),
DropdownMenuItem(value: "BSCS-5F", child: Text("BSCS-5F")),

DropdownMenuItem(value: "BSCS-6A", child: Text("BSCS-6A")),
DropdownMenuItem(value: "BSCS-6B", child: Text("BSCS-6B")),
DropdownMenuItem(value: "BSCS-6C", child: Text("BSCS-6C")),
DropdownMenuItem(value: "BSCS-6D", child: Text("BSCS-6D")),
DropdownMenuItem(value: "BSCS-6E", child: Text("BSCS-6E")),
DropdownMenuItem(value: "BSCS-6F", child: Text("BSCS-6F")),

DropdownMenuItem(value: "BSCS-7A", child: Text("BSCS-7A")),
DropdownMenuItem(value: "BSCS-7B", child: Text("BSCS-7B")),
DropdownMenuItem(value: "BSCS-7C", child: Text("BSCS-7C")),
DropdownMenuItem(value: "BSCS-7D", child: Text("BSCS-7D")),
DropdownMenuItem(value: "BSCS-7E", child: Text("BSCS-7E")),
DropdownMenuItem(value: "BSCS-7F", child: Text("BSCS-7F")),

DropdownMenuItem(value: "BSCS-8A", child: Text("BSCS-8A")),
DropdownMenuItem(value: "BSCS-8B", child: Text("BSCS-8B")),
DropdownMenuItem(value: "BSCS-8C", child: Text("BSCS-8C")),
DropdownMenuItem(value: "BSCS-8D", child: Text("BSCS-8D")),
DropdownMenuItem(value: "BSCS-8E", child: Text("BSCS-8E")),
DropdownMenuItem(value: "BSCS-8F", child: Text("BSCS-8F")),

// ---------- BSSE ----------
DropdownMenuItem(value: "BSSE-1A", child: Text("BSSE-1A")),
DropdownMenuItem(value: "BSSE-1B", child: Text("BSSE-1B")),
DropdownMenuItem(value: "BSSE-2A", child: Text("BSSE-2A")),
DropdownMenuItem(value: "BSSE-2B", child: Text("BSSE-2B")),
DropdownMenuItem(value: "BSSE-3A", child: Text("BSSE-3A")),
DropdownMenuItem(value: "BSSE-3B", child: Text("BSSE-3B")),
DropdownMenuItem(value: "BSSE-4A", child: Text("BSSE-4A")),
DropdownMenuItem(value: "BSSE-4B", child: Text("BSSE-4B")),
DropdownMenuItem(value: "BSSE-5A", child: Text("BSSE-5A")),
DropdownMenuItem(value: "BSSE-5B", child: Text("BSSE-5B")),
DropdownMenuItem(value: "BSSE-6A", child: Text("BSSE-6A")),
DropdownMenuItem(value: "BSSE-6B", child: Text("BSSE-6B")),
DropdownMenuItem(value: "BSSE-7A", child: Text("BSSE-7A")),
DropdownMenuItem(value: "BSSE-7B", child: Text("BSSE-7B")),
DropdownMenuItem(value: "BSSE-8A", child: Text("BSSE-8A")),
DropdownMenuItem(value: "BSSE-8B", child: Text("BSSE-8B")),

// ---------- BSAI ----------
DropdownMenuItem(value: "BSAI-1A", child: Text("BSAI-1A")),
DropdownMenuItem(value: "BSAI-1B", child: Text("BSAI-1B")),
DropdownMenuItem(value: "BSAI-2A", child: Text("BSAI-2A")),
DropdownMenuItem(value: "BSAI-2B", child: Text("BSAI-2B")),
DropdownMenuItem(value: "BSAI-3A", child: Text("BSAI-3A")),
DropdownMenuItem(value: "BSAI-3B", child: Text("BSAI-3B")),
DropdownMenuItem(value: "BSAI-4A", child: Text("BSAI-4A")),
DropdownMenuItem(value: "BSAI-4B", child: Text("BSAI-4B")),
DropdownMenuItem(value: "BSAI-5A", child: Text("BSAI-5A")),
DropdownMenuItem(value: "BSAI-5B", child: Text("BSAI-5B")),
DropdownMenuItem(value: "BSAI-6A", child: Text("BSAI-6A")),
DropdownMenuItem(value: "BSAI-6B", child: Text("BSAI-6B")),
DropdownMenuItem(value: "BSAI-7A", child: Text("BSAI-7A")),
DropdownMenuItem(value: "BSAI-7B", child: Text("BSAI-7B")),
DropdownMenuItem(value: "BSAI-8A", child: Text("BSAI-8A")),
DropdownMenuItem(value: "BSAI-8B", child: Text("BSAI-8B")),
              ],
              onChanged: (value) => setState(() => section = value!),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: guardianNameController,
              decoration: const InputDecoration(
                labelText: "Guardian Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: guardianPhoneController,
              decoration: const InputDecoration(
                labelText: "Guardian Phone",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: cgpaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "CGPA",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: isSaving ? null : _save,
                child: isSaving
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.student == null ? "Add Student" : "Update Student"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}