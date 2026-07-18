import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ExcelService {
  static Future<void> generateReport({
    required int totalStudents,
    required int totalLecturers,
    required int totalCourses,
    required int totalDepartments,
    required int totalNotices,
  }) async {
    final excel = Excel.createExcel();

    final Sheet sheet = excel['Analytics'];

    sheet.appendRow([
      TextCellValue("CampusOne Reports & Analytics"),
    ]);

    sheet.appendRow([]);

    sheet.appendRow([
      TextCellValue("Metric"),
      TextCellValue("Value"),
    ]);

    sheet.appendRow([
      TextCellValue("Total Students"),
      IntCellValue(totalStudents),
    ]);

    sheet.appendRow([
      TextCellValue("Total Lecturers"),
      IntCellValue(totalLecturers),
    ]);

    sheet.appendRow([
      TextCellValue("Total Courses"),
      IntCellValue(totalCourses),
    ]);

    sheet.appendRow([
      TextCellValue("Total Departments"),
      IntCellValue(totalDepartments),
    ]);

    sheet.appendRow([
      TextCellValue("Total Notices"),
      IntCellValue(totalNotices),
    ]);

    final directory =
        await getApplicationDocumentsDirectory();

    final file = File(
      "${directory.path}/CampusOne_Report.xlsx",
    );

    final bytes = excel.encode();

    if (bytes != null) {
      await file.writeAsBytes(bytes);
      await OpenFilex.open(file.path);
    }
  }
}