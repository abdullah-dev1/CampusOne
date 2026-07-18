import 'package:flutter/material.dart';

import '../../data/mock/mock_assignments.dart';
import '../../data/models/assignment_model.dart';

import '../widgets/assignment_card.dart';
import '../widgets/assignment_filter_tabs.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _OverviewItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _OverviewItem({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  String selectedFilter = "All";

  Future<void> _refresh() async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    setState(() {});
  }

  List<AssignmentModel> get filteredAssignments {
    switch (selectedFilter) {
      case "Pending":
        return assignmentList
            .where((a) => !a.submitted && !a.late)
            .toList();

      case "Submitted":
        return assignmentList
            .where((a) => a.submitted)
            .toList();

      case "Late":
        return assignmentList
            .where((a) => a.late)
            .toList();

      default:
        return assignmentList;
    }
  }

  int get pendingCount =>
      assignmentList.where((a) => !a.submitted && !a.late).length;

  int get submittedCount =>
      assignmentList.where((a) => a.submitted).length;

  int get lateCount =>
      assignmentList.where((a) => a.late).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: const Text(
          "Assignments",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.w800,
            fontSize: 23,
            letterSpacing: -.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff2563EB).withOpacity(.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xff2563EB),
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: const Color(0xff2563EB),
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Track your academic progress",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -.5,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Manage every assignment from one place.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff2563EB),
                      Color(0xff1D4ED8),
                      Color(0xff1E40AF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff2563EB).withOpacity(.35),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Assignment Overview",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "${assignmentList.length} Total Assignments",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          child: _OverviewItem(
                            title: "Pending",
                            value: pendingCount.toString(),
                            color: Colors.orange,
                          ),
                        ),
                        Expanded(
                          child: _OverviewItem(
                            title: "Submitted",
                            value: submittedCount.toString(),
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          child: _OverviewItem(
                            title: "Late",
                            value: lateCount.toString(),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              AssignmentFilterTabs(
                selectedFilter: selectedFilter,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value;
                  });
                },
              ),

              const SizedBox(height: 28),

              Text(
                "${filteredAssignments.length} Assignments",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                ),
              ),

              const SizedBox(height: 20),

              if (filteredAssignments.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.grey.shade100,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff2563EB).withOpacity(.08),
                        ),
                        child: const Icon(
                          Icons.assignment_turned_in_rounded,
                          size: 46,
                          color: Color(0xff2563EB),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "No Assignments Found",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff0F172A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Everything looks clear for this category.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

              if (filteredAssignments.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAssignments.length,
                  itemBuilder: (context, index) {
                    return AssignmentCard(
                      assignment: filteredAssignments[index],
                    );
                  },
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}