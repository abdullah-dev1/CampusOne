import 'package:flutter/material.dart';

import '../../data/dashboard_data.dart';
import '../widgets/dashboard_card.dart';

import 'package:provider/provider.dart';
import '../provider/student_provider.dart';

import '../widgets/dashboard_grid.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats.dart';
import '../widgets/quick_actions.dart';
import '../widgets/student_info_card.dart';
import '../widgets/animated_dashboard_section.dart';
class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() =>
      _StudentDashboardPageState();
}

class _StudentDashboardPageState
    extends State<StudentDashboardPage> {

@override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<StudentProvider>().loadStudent();
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8FAFC),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.fromLTRB(
            22,
            20,
            22,
            120,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: const [

              AnimatedDashboardSection(
  delay: const Duration(milliseconds: 100),
  child: DashboardHeader(),
),

              SizedBox(height: 28),

             AnimatedDashboardSection(
  delay: const Duration(milliseconds: 200),
  child: StudentInfoCard(),
),

              SizedBox(height: 34),

         AnimatedDashboardSection(
  delay: const Duration(milliseconds: 400),
  child: QuickActions(),
),
              SizedBox(height: 34),

             AnimatedDashboardSection(
  delay: const Duration(milliseconds: 500),
  child: DashboardGrid(),
),

            ],
          ),
        ),
      ),

     
    );
  }
}