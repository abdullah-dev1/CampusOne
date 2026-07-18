import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'core/services/service_locator.dart';
import 'firebase_options.dart';
import 'features/attendance/presentation/provider/student_attendance_provider.dart';
import 'features/admin/presentation/provider/admin_provider.dart';
import 'features/attendance/presentation/provider/attendance_provider.dart';
import 'features/grades/presentation/provider/grade_provider.dart';
import 'features/lecturer/presentation/provider/lecturer_provider.dart';
import 'features/lecturer/presentation/provider/lecturer_students_provider.dart';
import 'package:campusone/features/notices/presentation/provider/notice_provider.dart';

import 'features/student/presentation/provider/student_provider.dart';
import 'package:campusone/features/admin/notice_management/data/repository/firebase_notice_repository.dart';
import 'features/student/presentation/provider/student_grade_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Dependency Injection
  await setupServiceLocator();

  runApp(
    MultiProvider(
      
      providers: [

        ChangeNotifierProvider(
  create: (_) => StudentAttendanceProvider(),
),

        ChangeNotifierProvider(
  create: (_) => StudentProvider(),
),
        ChangeNotifierProvider(
          create: (_) => AttendanceProvider(),
        ),
        ChangeNotifierProvider(
  create: (_) => NoticeProvider(
    FirebaseNoticeRepository(),
  ),
),
        ChangeNotifierProvider(
          create: (_) => AdminProvider(),
        ),
       ChangeNotifierProvider(
  create: (_) => LecturerStudentsProvider(),
),
        ChangeNotifierProvider(
          create: (_) => GradeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LecturerProvider(),
        ),
        ChangeNotifierProvider(
  create: (_) => StudentGradeProvider(),
),
      ],
      child: const CampusOneApp(),
    ),
  );
}