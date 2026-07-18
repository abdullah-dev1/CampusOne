import 'package:cloud_firestore/cloud_firestore.dart';

enum StudentStatus {
  active,
  inactive,
}

enum StudentGender {
  male,
  female,
}

class StudentModel {
  final String id;

  String registrationNo;
  String fullName;

  String email;
  String phone;

  String cnic;

  StudentGender gender;

  String dateOfBirth;

  String department;
  String semester;
  String section;

  String address;

  String guardianName;
  String guardianPhone;

  String profileImage;

  double cgpa;

  StudentStatus status;

  DateTime? createdAt;

  StudentModel({
    required this.id,
    required this.registrationNo,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.gender,
    required this.dateOfBirth,
    required this.department,
    required this.semester,
    required this.section,
    required this.address,
    required this.guardianName,
    required this.guardianPhone,
    required this.profileImage,
    required this.cgpa,
    this.status = StudentStatus.active,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'registrationNo': registrationNo,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'gender': gender.name,
      'dateOfBirth': dateOfBirth,
      'department': department,
      'semester': semester,
      'section': section,
      'address': address,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
      'profileImage': profileImage,
      'cgpa': cgpa,
      'status': status.name,
      'role': 'student',
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  factory StudentModel.fromMap(String id, Map<String, dynamic> map) {
    return StudentModel(
      id: id,
      registrationNo: map['registrationNo'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      cnic: map['cnic'] ?? '',
      gender: (map['gender'] == 'female')
          ? StudentGender.female
          : StudentGender.male,
      dateOfBirth: map['dateOfBirth'] ?? '',
      department: map['department'] ?? '',
      semester: map['semester'] ?? '',
      section: map['section'] ?? '',
      address: map['address'] ?? '',
      guardianName: map['guardianName'] ?? '',
      guardianPhone: map['guardianPhone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      cgpa: (map['cgpa'] ?? 0).toDouble(),
      status: (map['status'] == 'inactive')
          ? StudentStatus.inactive
          : StudentStatus.active,
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}