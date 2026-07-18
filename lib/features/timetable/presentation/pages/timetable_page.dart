import 'package:flutter/material.dart';
import '../../data/mock/mock_timetable.dart';
import '../../data/models/timetable_model.dart';
import '../widgets/class_card.dart';
import '../widgets/current_class_card.dart';
import '../widgets/day_selector.dart';
import '../widgets/empty_schedule.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  String selectedDay = "Mon";

  final Map<String, String> dayMap = const {
    "Mon": "Monday",
    "Tue": "Tuesday",
    "Wed": "Wednesday",
    "Thu": "Thursday",
    "Fri": "Friday",
    "Sat": "Saturday",
    "Sun": "Sunday",
  };

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {});
  }

  List<TimetableModel> get filteredClasses {
    return timetableList.where((item) {
      return item.day == dayMap[selectedDay];
    }).toList();
  }

  TimetableModel? get currentClass {
    if (filteredClasses.isEmpty) {
      return null;
    }
    return filteredClasses.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff0F172A),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Class Timetable",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
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
                  Icons.calendar_month_rounded,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Weekly Schedule",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Stay organized and never miss a lecture.",
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 28),
              DaySelector(
                selectedDay: selectedDay,
                onDaySelected: (day) {
                  setState(() {
                    selectedDay = day;
                  });
                },
              ),
              const SizedBox(height: 28),
              if (currentClass != null)
                CurrentClassCard(
                  currentClass: currentClass!,
                ),
              if (currentClass != null) const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    "Today's Classes",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0F172A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff2563EB).withOpacity(.10),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xff2563EB).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "${filteredClasses.length} Classes",
                      style: const TextStyle(
                        color: Color(0xff2563EB),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              if (filteredClasses.isEmpty) const EmptySchedule(),
              if (filteredClasses.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredClasses.length,
                  itemBuilder: (context, index) {
                    final lecture = filteredClasses[index];
                    return ClassCard(
                      timetable: lecture,
                      isCurrentClass: index == 0,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}