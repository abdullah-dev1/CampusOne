import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lecturer_provider.dart';

import '../widgets/dashboard_header.dart';
import '../widgets/lecturer_info_card.dart';

import '../widgets/quick_actions.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/animated_dashboard_section.dart';

class LecturerDashboardPage extends StatefulWidget {
  const LecturerDashboardPage({super.key});

  @override
  State<LecturerDashboardPage> createState() =>
      _LecturerDashboardPageState();
}

class _LecturerDashboardPageState
    extends State<LecturerDashboardPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LecturerProvider>().loadLecturer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff2563EB).withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff8B5CF6).withOpacity(0.04),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                22,
                20,
                22,
                40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AnimatedDashboardSection(
                    delay: Duration(milliseconds: 100),
                    child: DashboardHeader(),
                  ),
                  SizedBox(height: 28),
                  AnimatedDashboardSection(
                    delay: Duration(milliseconds: 200),
                    child: LecturerInfoCard(),
                  ),
                  SizedBox(height: 24),
                 
                  AnimatedDashboardSection(
                    delay: Duration(milliseconds: 400),
                    child: QuickActions(),
                  ),
                  SizedBox(height: 34),
                  AnimatedDashboardSection(
                    delay: Duration(milliseconds: 500),
                    child: DashboardGrid(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}