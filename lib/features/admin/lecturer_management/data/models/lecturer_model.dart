import 'package:cloud_firestore/cloud_firestore.dart';
import 'teaching_assignment.dart';

enum LecturerStatus {
  active,
  inactive,
}

enum LecturerGender {
  male,
  female,
}

enum LecturerDesignation {
  professor,
  associateProfessor,
  assistantProfessor,
  lecturer,
  labEngineer,
}

class LecturerModel {
  final String id;

  String employeeId;
  String fullName;
  String email;
  String phone;
  String cnic;

  LecturerGender gender;

  String dateOfBirth;

  String department;

  LecturerDesignation designation;

  String qualification;

  String specialization;

  String officeLocation;

  String joiningDate;

  String address;

  String profileImage;

 List<TeachingAssignment> teachingAssignments;

  LecturerStatus status;

  DateTime createdAt;

  LecturerModel({
    required this.id,
    required this.employeeId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.gender,
    required this.dateOfBirth,
    required this.department,
    required this.designation,
    required this.qualification,
    required this.specialization,
    required this.officeLocation,
    required this.joiningDate,
    required this.address,
    required this.profileImage,
  this.teachingAssignments = const [],
    this.status = LecturerStatus.active,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory LecturerModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return LecturerModel(
      id: id,
      employeeId: map['employeeId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      cnic: map['cnic'] ?? '',
      gender: LecturerGender.values.firstWhere(
        (e) => e.name == map['gender'],
        orElse: () => LecturerGender.male,
      ),
      dateOfBirth: map['dateOfBirth'] ?? '',
      department: map['department'] ?? '',
      designation: LecturerDesignation.values.firstWhere(
        (e) => e.name == map['designation'],
        orElse: () => LecturerDesignation.lecturer,
      ),
      qualification: map['qualification'] ?? '',
      specialization: map['specialization'] ?? '',
      officeLocation: map['officeLocation'] ?? '',
      joiningDate: map['joiningDate'] ?? '',
      address: map['address'] ?? '',
      profileImage: map['profileImage'] ?? '',
     teachingAssignments:
(map['teachingAssignments'] as List? ?? [])
    .map(
      (e) => TeachingAssignment.fromMap(
        Map<String, dynamic>.from(e),
      ),
    )
    .toList(),
      status: LecturerStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => LecturerStatus.active,
      ),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'gender': gender.name,
      'dateOfBirth': dateOfBirth,
      'department': department,
      'designation': designation.name,
      'qualification': qualification,
      'specialization': specialization,
      'officeLocation': officeLocation,
      'joiningDate': joiningDate,
      'address': address,
      'profileImage': profileImage,
     'teachingAssignments':
teachingAssignments
    .map((e) => e.toMap())
    .toList(),
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  LecturerModel copyWith({
  String? id,
  String? employeeId,
  String? fullName,
  String? email,
  String? phone,
  String? cnic,
  LecturerGender? gender,
  String? dateOfBirth,
  String? department,
  LecturerDesignation? designation,
  String? qualification,
  String? specialization,
  String? officeLocation,
  String? joiningDate,
  String? address,
  String? profileImage,
  List<TeachingAssignment>? teachingAssignments,
  LecturerStatus? status,
  DateTime? createdAt,
}) {
  return LecturerModel(
    id: id ?? this.id,
    employeeId: employeeId ?? this.employeeId,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    cnic: cnic ?? this.cnic,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    department: department ?? this.department,
    designation: designation ?? this.designation,
    qualification: qualification ?? this.qualification,
    specialization: specialization ?? this.specialization,
    officeLocation: officeLocation ?? this.officeLocation,
    joiningDate: joiningDate ?? this.joiningDate,
    address: address ?? this.address,
    profileImage: profileImage ?? this.profileImage,
    teachingAssignments:
        teachingAssignments ?? this.teachingAssignments,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
}
}