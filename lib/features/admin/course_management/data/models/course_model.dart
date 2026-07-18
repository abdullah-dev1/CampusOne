import 'package:cloud_firestore/cloud_firestore.dart';

enum CourseStatus {
  active,
  inactive,
}

enum CourseType {
  core,
  elective,
}

class CourseModel {
  final String id;
  final String courseCode;
  final String courseTitle;
  final String department;
  final String semester;
  final int creditHours;
  final CourseType type;
  final String description;
  final List<String> prerequisites;
  final String assignedLecturer;
  final List<String> assignedSections;
  final int totalStudents;
  final CourseStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseModel({
    required this.id,
    required this.courseCode,
    required this.courseTitle,
    required this.department,
    required this.semester,
    required this.creditHours,
    required this.type,
    required this.description,
    this.prerequisites = const [],
    this.assignedLecturer = '',
    this.assignedSections = const [],
    this.totalStudents = 0,
    this.status = CourseStatus.active,
    required this.createdAt,
    required this.updatedAt,
  });

  CourseModel copyWith({
    String? id,
    String? courseCode,
    String? courseTitle,
    String? department,
    String? semester,
    int? creditHours,
    CourseType? type,
    String? description,
    List<String>? prerequisites,
    String? assignedLecturer,
    List<String>? assignedSections,
    int? totalStudents,
    CourseStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      courseCode: courseCode ?? this.courseCode,
      courseTitle: courseTitle ?? this.courseTitle,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      creditHours: creditHours ?? this.creditHours,
      type: type ?? this.type,
      description: description ?? this.description,
      prerequisites: prerequisites ?? this.prerequisites,
      assignedLecturer: assignedLecturer ?? this.assignedLecturer,
      assignedSections: assignedSections ?? this.assignedSections,
      totalStudents: totalStudents ?? this.totalStudents,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] ?? '',
      courseCode: map['courseCode'] ?? map['code'] ?? '',
      courseTitle: map['courseTitle'] ?? map['name'] ?? '',
      department: map['department'] ?? map['departmentName'] ?? '',
      semester: _parseSemester(map['semester']),
      creditHours: map['creditHours'] ?? 0,
      type: _parseType(map['type']),
      description: map['description'] ?? '',
      prerequisites: List<String>.from(map['prerequisites'] ?? []),
      assignedLecturer:
          map['assignedLecturer'] ?? map['instructor'] ?? '',
      assignedSections:
          List<String>.from(map['assignedSections'] ?? []),
      totalStudents: map['totalStudents'] ?? 0,
      status: map['status'] == 'inactive'
          ? CourseStatus.inactive
          : CourseStatus.active,
      createdAt: _parseDate(map['createdAt']),
      updatedAt: _parseDate(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseCode': courseCode,
      'courseTitle': courseTitle,
      'department': department,
      'semester': semester,
      'creditHours': creditHours,
      'type': type.name,
      'description': description,
      'prerequisites': prerequisites,
      'assignedLecturer': assignedLecturer,
      'assignedSections': assignedSections,
      'totalStudents': totalStudents,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static String _parseSemester(dynamic value) {
    if (value == null) {
      return '1';
    }
    return value.toString();
  }

  static CourseType _parseType(dynamic value) {
    if (value == CourseType.elective.name) {
      return CourseType.elective;
    }
    return CourseType.core;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.now();
  }
}
