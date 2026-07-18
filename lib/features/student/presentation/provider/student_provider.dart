import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StudentModel _student = const StudentModel(
    id: "",
    name: "",
    email: "",
    registrationNo: "",
    department: "",
    program: "",
    semester: "",
    session: "",
    profileImage: "",
    cgpa: 0,
    credits: 0,
    attendance: 0,
  );

  StudentModel get student => _student;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> loadStudent() async {
    try {
      _loading = true;
      notifyListeners();

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _loading = false;
        notifyListeners();
        return;
      }

      final snapshot = await _firestore
          .collection("students")
          .where("email", isEqualTo: user.email)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        debugPrint("No student found for ${user.email}");
        _loading = false;
        notifyListeners();
        return;
      }

      final data = snapshot.docs.first.data();

      _student = StudentModel(
        id: snapshot.docs.first.id,
        name: data["fullName"] ?? "",
        email: data["email"] ?? "",
        registrationNo: data["registrationNo"] ?? "",
        department: data["department"] ?? "",
        program: "BS Computer Science",
        semester: data["semester"] ?? "",
        session: "2024 - 2028",
        profileImage: data["profileImage"] ?? "",
        cgpa: (data["cgpa"] ?? 0).toDouble(),
        credits: 0,
        attendance: 0,
      );

      _loading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("StudentProvider Error: $e");
      _loading = false;
      notifyListeners();
    }
  }

  void updateStudent(StudentModel value) {
    _student = value;
    notifyListeners();
  }
}