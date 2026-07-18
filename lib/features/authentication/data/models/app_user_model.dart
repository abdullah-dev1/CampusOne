import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserModel {
  final String uid;
  final String fullName;
  final String email;
  final String role;
  final String? department;
  final bool isActive;

  const AppUserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.role,
    this.department,
    required this.isActive,
  });

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      department: map['department'],
      isActive: map['isActive'] ?? true,
    );
  }

  factory AppUserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return AppUserModel(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      department: data['department'],
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'role': role,
      'department': department,
      'isActive': isActive,
    };
  }
}