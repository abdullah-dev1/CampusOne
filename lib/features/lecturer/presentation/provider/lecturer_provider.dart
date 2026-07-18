import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../admin/lecturer_management/data/models/lecturer_model.dart';

class LecturerProvider extends ChangeNotifier {
  LecturerModel? _lecturer;

  LecturerModel? get lecturer => _lecturer;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadLecturer() async {
  try {
    _isLoading = true;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _lecturer = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('lecturers')
        .where('email', isEqualTo: user.email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      _lecturer = null;
    } else {
      final doc = snapshot.docs.first;

      _lecturer = LecturerModel.fromMap(
  doc.id,
  doc.data(),
);

debugPrint("Loaded Lecturer: ${_lecturer!.fullName}");
debugPrint("PROFILE => ${_lecturer!.profileImage}");
debugPrint(
  "PROFILE LENGTH = ${_lecturer!.profileImage.length}",
);
    }

    _isLoading = false;
    notifyListeners();
  } catch (e) {
    _isLoading = false;
    notifyListeners();
    debugPrint(e.toString());
  }
}
}