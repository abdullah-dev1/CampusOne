import '../models/grade_model.dart';

List<GradeModel> createDummyGrades() {
  return [
    GradeModel(
      studentId: "1",
      studentName: "Muhammad Abdullah",
      registrationNo: "24P-0563",
    ),
    GradeModel(
      studentId: "2",
      studentName: "Aymen",
      registrationNo: "24F-0187",
    ),
    GradeModel(
      studentId: "3",
      studentName: "Ahmad Hassan",
      registrationNo: "24F-0562",
    ),
    GradeModel(
      studentId: "4",
      studentName: "Usman Tariq",
      registrationNo: "24F-0309",
    ),
    GradeModel(
      studentId: "5",
      studentName: "Bilal Ahmed",
      registrationNo: "24F-0678",
    ),
  ];
}