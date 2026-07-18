import 'package:flutter/material.dart';

import 'models/dashboard_card_model.dart';

class DashboardData {
  static List<DashboardCardModel> cards = [

    DashboardCardModel(
      title: "Attendance",
      subtitle: "View attendance record",
      icon: Icons.fact_check_rounded,
      color: Colors.blue,
      route: "/attendance",
    ),

    DashboardCardModel(
      title: "Timetable",
      subtitle: "Today's classes",
      icon: Icons.calendar_month,
      color: Colors.green,
      route: "/timetable",
    ),

    DashboardCardModel(
      title: "Assignments",
      subtitle: "Pending work",
      icon: Icons.assignment,
      color: Colors.orange,
      route: "/assignments",
    ),

    DashboardCardModel(
      title: "Transcript",
      subtitle: "Semester results",
      icon: Icons.school,
      color: Colors.purple,
      route: "/transcript",
    ),

    DashboardCardModel(
      title: "Fees",
      subtitle: "Fee status",
      icon: Icons.account_balance_wallet,
      color: Colors.red,
      route: "/fees",
    ),

    DashboardCardModel(
      title: "Notifications",
      subtitle: "Latest announcements",
      icon: Icons.notifications_active,
      color: Colors.teal,
      route: "/notifications",
    ),
  ];
}