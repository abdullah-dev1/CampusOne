import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentAttendanceProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> get records => _records;

  Future<void> loadAttendance() async {
    _loading = true;
    notifyListeners();

    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        _records = [];
        _loading = false;
        notifyListeners();
        return;
      }

      //--------------------------------------------------
      // Get logged-in student's CampusOne profile
      //--------------------------------------------------

      final userDoc = await _firestore
          .collection("users")
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        _records = [];
        _loading = false;
        notifyListeners();
        return;
      }

      final studentEmail = userDoc.data()?["email"];

      debugPrint("CampusOne Email: $studentEmail");

      //--------------------------------------------------
      // Load Attendance
      //--------------------------------------------------

      final snapshot = await _firestore
          .collection("attendance")
          .where("studentEmail", isEqualTo: studentEmail)
          .get();

      _records = snapshot.docs
          .map((e) => e.data())
          .toList();

      _records.sort((a, b) {
        final ta = a["savedAt"] as Timestamp?;
        final tb = b["savedAt"] as Timestamp?;

        if (ta == null || tb == null) return 0;

        return tb.compareTo(ta);
      });

      debugPrint("Attendance Found: ${_records.length}");
    } catch (e) {
      debugPrint(e.toString());
      _records = [];
    }

    _loading = false;
    notifyListeners();
  }

  int get totalClasses => _records.length;

  int get presentCount =>
      _records.where((e) => e["status"] == "present").length;

  int get absentCount =>
      _records.where((e) => e["status"] == "absent").length;

  int get lateCount =>
      _records.where((e) => e["status"] == "late").length;

  double get attendancePercentage {
    if (totalClasses == 0) return 0;

    return ((presentCount + (lateCount * 0.5)) /
            totalClasses) *
        100;
  }
}