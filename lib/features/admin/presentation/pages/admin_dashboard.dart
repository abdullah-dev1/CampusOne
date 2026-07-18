import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/admin_provider.dart';
import '../widgets/admin_analytics.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_quick_actions.dart';
import '../widgets/admin_recent_activity.dart';
import '../widgets/admin_system_overview.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AdminProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Dashboard"),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [

            AdminHeader(),

            SizedBox(height: 24),

            AdminQuickActions(),

            SizedBox(height: 28),


          ],
        ),
      ),
    );
  }
}