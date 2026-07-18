import 'package:go_router/go_router.dart';

import '../../features/student/presentation/pages/student_grades_page.dart';
import '../../features/shared/presentation/pages/splash_page.dart';
import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/student/presentation/pages/student_dashboard_page.dart';
import '../../features/lecturer/presentation/pages/lecturer_dashboard_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard.dart';
import 'package:campusone/features/timetable/presentation/pages/timetable_page.dart';
import 'package:campusone/features/student/presentation/pages/student_main_page.dart';
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/student/dashboard',
        builder: (context, state) => const StudentMainPage(),
      ),
      GoRoute(
        path: '/lecturer/dashboard',
        builder: (context, state) => const LecturerDashboardPage(),
      ),
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboard(),
      ),
      GoRoute(
  path: '/student/grades',
  builder: (context, state) =>
      const StudentGradesPage(),
),
    
    ],
  );
}