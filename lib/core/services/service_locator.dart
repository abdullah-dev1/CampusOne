import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/admin/lecturer_management/domain/repository/lecturer_repository.dart';
import '../../features/admin/lecturer_management/data/repository/firebase_lecturer_repository.dart';
import 'auth_service.dart';
import 'admin_account_service.dart';

import '../../features/authentication/domain/repository/auth_repository.dart';
import '../../features/authentication/data/repository/firebase_auth_repository.dart';

import '../../features/admin/student_management/domain/repository/student_repository.dart';
import '../../features/admin/student_management/data/repository/firebase_student_repository.dart';
import '../../features/admin/department_management/domain/repository/department_repository.dart';
import '../../features/admin/department_management/data/repository/firebase_department_repository.dart';
import '../../features/admin/course_management/domain/repository/course_repository.dart';
import '../../features/admin/course_management/data/repository/course_repository_impl.dart';
import '../../features/admin/notice_management/domain/repository/notice_repository.dart';
import '../../features/admin/notice_management/data/repository/firebase_notice_repository.dart';

final GetIt locator = GetIt.instance;

// Alias so `sl<T>()` works the same as `locator<T>()`
final GetIt sl = locator;

Future<void> setupServiceLocator() async {
  locator.registerLazySingleton<AuthService>(
    () => AuthService(),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(locator<AuthService>()),
  );

  locator.registerLazySingleton<AdminAccountService>(
    () => AdminAccountService(),
  );

  locator.registerLazySingleton<StudentRepository>(
    () => FirebaseStudentRepository(
      FirebaseFirestore.instance,
      locator<AdminAccountService>(),
    ),
  );
  locator.registerLazySingleton<DepartmentRepository>(
  () => FirebaseDepartmentRepository(
    FirebaseFirestore.instance,
  ),
);
  locator.registerLazySingleton<LecturerRepository>(
  () => FirebaseLecturerRepository(
    FirebaseFirestore.instance,
    locator<AdminAccountService>(),
  ),
);
  locator.registerLazySingleton<CourseRepository>(
    () => CourseRepositoryImpl(
      firestore: FirebaseFirestore.instance,
    ),
  );
  locator.registerLazySingleton<NoticeRepository>(
  () => FirebaseNoticeRepository(
    firestore: FirebaseFirestore.instance,
  ),
);
}