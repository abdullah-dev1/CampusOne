import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../student_management/presentation/provider/student_management_provider.dart';
import '../../../lecturer_management/presentation/provider/lecturer_management_provider.dart';
import '../../../course_management/presentation/provider/course_management_provider.dart';
import '../../../department_management/presentation/provider/department_management_provider.dart';
import '../../../notice_management/presentation/provider/notice_management_provider.dart';
import '../provider/reports_analytics_provider.dart';
import '../widgets/analytics_header.dart';
import '../widgets/statistics_cards.dart';
import '../widgets/quick_insights.dart';
import '../widgets/student_chart.dart';
import '../widgets/lecturer_chart.dart';
import '../widgets/course_chart.dart';
import '../widgets/department_chart.dart';
import '../widgets/notice_chart.dart';
import '../widgets/export_buttons.dart';
import '../../../student_management/domain/repository/student_repository.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../lecturer_management/domain/repository/lecturer_repository.dart';
import '../../../department_management/domain/repository/department_repository.dart';
import '../../../course_management/domain/repository/course_repository.dart';
import 'package:campusone/features/admin/notice_management/domain/repository/notice_repository.dart';

class ReportsAnalyticsPage extends StatelessWidget {
  const ReportsAnalyticsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentManagementProvider(sl<StudentRepository>()),
        ),
        ChangeNotifierProvider(
          create: (_) => LecturerManagementProvider(
      locator<LecturerRepository>(),
),
        ),
        ChangeNotifierProvider(
          create: (_) => CourseManagementProvider(
            locator<CourseRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DepartmentManagementProvider(
    locator<DepartmentRepository>(),
),
        ),
       ChangeNotifierProvider(
  create: (_) {
    final provider = NoticeManagementProvider(
      locator<NoticeRepository>(),
    );

    provider.loadNotices();

    return provider;
  },
),
        ChangeNotifierProvider(
          create: (_) => ReportsAnalyticsProvider(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            "Reports & Analytics",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              // Future:
              // provider.refreshAnalytics();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: const [
                AnalyticsHeader(),
                SizedBox(height: 20),
                SizedBox(height: 24),
                StatisticsCards(),
                SizedBox(height: 24),
                
                StudentChart(),
                SizedBox(height: 24),
                LecturerChart(),
                SizedBox(height: 24),
                CourseChart(),
                SizedBox(height: 24),
                DepartmentChart(),
                SizedBox(height: 24),
                NoticeChart(),
                SizedBox(height: 24),
                ExportButtons(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}