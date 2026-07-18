import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_attendance_provider.dart';
import '../../../student/presentation/provider/student_provider.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() =>
      _StudentAttendancePageState();
}

class _StudentAttendancePageState
    extends State<StudentAttendancePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
     final studentEmail =
    context.read<StudentProvider>().student.email;

context
    .read<StudentAttendanceProvider>()
    .loadAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<StudentAttendanceProvider>();

    if (provider.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    
final attendance = provider.records;
    final total = attendance.length;
final present = attendance
    .where((e) => e["status"] == "present")
    .length;

final absent = attendance
    .where((e) => e["status"] == "absent")
    .length;

final late = attendance
    .where((e) => e["status"] == "late")
    .length;
    

    final percentage = total == 0
        ? 0
        : (present / total) * 100;

    return Scaffold(
      backgroundColor:
          const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Attendance",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: attendance.isEmpty
          ? const Center(
              child: Text(
                "No Attendance Available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : ListView(
              padding:
                  const EdgeInsets.all(20),
              children: [

                //--------------------------------
                // HERO CARD
                //--------------------------------

                Container(
                  padding:
                      const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(
                            30),
                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(0xff2563EB),
                        Color(0xff1D4ED8),
                        Color(0xff1E40AF),
                      ],
                      begin:
                          Alignment.topLeft,
                      end: Alignment
                          .bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                                0xff2563EB)
                            .withOpacity(.30),
                        blurRadius: 30,
                        offset:
                            const Offset(
                                0,
                                14),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      const Text(
                        "Overall Attendance",
                        style: TextStyle(
                          color:
                              Colors.white70,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(
                          height: 9),

                      SizedBox(
                        width: 140,
                        height: 140,

                        child: Stack(
                          alignment:
                              Alignment
                                  .center,

                          children: [

                            SizedBox(
                              width: 140,
                              height: 140,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 12,
                                value:
                                    percentage /
                                        100,
                                backgroundColor:
                                    Colors.white24,
                                valueColor:
                                    const AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            ),

                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [

                                Text(
                                  "${percentage.toStringAsFixed(1)}%",
                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    fontSize:
                                        23,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        2),

                                const Text(
                                  "Attendance",
                                  style:
                                      TextStyle(
                                    color: Colors
                                        .white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 12),

                      Row(
                        children: [

                          Expanded(
                            child: _SummaryCard(
                              title:
                                  "Present",
                              value:
                                  present
                                      .toString(),
                              color:
                                  Colors.green,
                              icon:
                                  Icons.check_circle,
                            ),
                          ),

                          const SizedBox(
                              width: 14),

                          Expanded(
                            child: _SummaryCard(
                              title:
                                  "Absent",
                              value:
                                  absent
                                      .toString(),
                              color:
                                  Colors.red,
                              icon:
                                  Icons.cancel,
                            ),
                          ),

                          const SizedBox(
                              width: 14),

                          Expanded(
                            child: _SummaryCard(
                              title:
                                  "Late",
                              value:
                                  late
                                      .toString(),
                              color:
                                  Colors.orange,
                              icon:
                                  Icons.watch_later,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Attendance History",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height:10),

                                //--------------------------------
                // ATTENDANCE HISTORY
                //--------------------------------

                ...attendance.map((record) {
                  Color statusColor;
                  IconData statusIcon;

                  switch((record["status"] as String).toLowerCase()) {
                    case "present":
                      statusColor = Colors.green;
                      statusIcon = Icons.check_circle_rounded;
                      break;

                    case "late":
                      statusColor = Colors.orange;
                      statusIcon = Icons.schedule_rounded;
                      break;

                    default:
                      statusColor = Colors.red;
                      statusIcon = Icons.cancel_rounded;
                  }

                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.04),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [

                          //--------------------------------
                          // STATUS ICON
                          //--------------------------------

                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(.12),
                              borderRadius:
                                  BorderRadius.circular(18),
                            ),
                            child: Icon(
                              statusIcon,
                              color: statusColor,
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 10),

                          //--------------------------------
                          // DETAILS
                          //--------------------------------

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [

                                Text(
                                  record["course"],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                Text(
                                  record["date"],
                                  style: TextStyle(
                                    color:
                                        Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 3),

                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(8),
                                  child:
                                      LinearProgressIndicator(
                                    value: record["status"] ==
                                            "present"
                                        ? 1
                                        : record["status"] ==
                                                "late"
                                            ? .60
                                            : .20,
                                    minHeight: 7,
                                    backgroundColor:
                                        Colors.grey.shade200,
                                    valueColor:
                                        AlwaysStoppedAnimation(
                                      statusColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 4),

                          //--------------------------------
                          // STATUS CHIP
                          //--------------------------------

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  statusColor.withOpacity(.10),
                              borderRadius:
                                  BorderRadius.circular(30),
                            ),
                            child: Text(
                              record["status"]
                                  .toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 12),

                              ],
            ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(.85),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}