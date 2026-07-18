import 'package:cloud_firestore/cloud_firestore.dart';

class GradeModel {
  final String id;

  final String studentId;
  final String lecturerId;

  final String studentName;
  final String registrationNo;

  final String course;
  final String section;
  final String assessment;

  double obtainedMarks;
  double totalMarks;

  bool published;


  GradeModel({
    required this.id,
    required this.studentId,
    required this.lecturerId,
    required this.studentName,
    required this.registrationNo,
    required this.course,
    required this.section,
    required this.assessment,
    this.obtainedMarks = 0,
    this.totalMarks = 10,
    this.published = false,
  });

  factory GradeModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return GradeModel(
      id: id,
      studentId: map["studentId"] ?? "",
      lecturerId: map["lecturerId"] ?? "",
      studentName: map["studentName"] ?? "",
      registrationNo: map["registrationNo"] ?? "",
      course: map["course"] ?? "",
      section: map["section"] ?? "",
      assessment: map["assessment"] ?? "",
      obtainedMarks:
          (map["obtainedMarks"] ?? 0).toDouble(),
      totalMarks:
          (map["totalMarks"] ?? 10).toDouble(),
      published: map["published"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "studentId": studentId,
      "lecturerId": lecturerId,
      "studentName": studentName,
      "registrationNo": registrationNo,
      "course": course,
      "section": section,
      "assessment": assessment,
      "obtainedMarks": obtainedMarks,
      "totalMarks": totalMarks,
      "published": published,
    };
  }
}