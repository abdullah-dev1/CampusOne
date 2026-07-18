import 'package:flutter/material.dart';

import '../models/timetable_model.dart';

const timetableList = [

  TimetableModel(
    subject: "Data Structures",
    instructor: "Dr. Ahmed",
    room: "Lab 4",
    startTime: "08:30 AM",
    endTime: "10:00 AM",
    day: "Monday",
    color: Color(0xff2563EB),
  ),

  TimetableModel(
    subject: "Operating Systems",
    instructor: "Dr. Hassan",
    room: "Room 202",
    startTime: "10:30 AM",
    endTime: "12:00 PM",
    day: "Monday",
    color: Color(0xff22C55E),
  ),

  TimetableModel(
    subject: "Database Systems",
    instructor: "Dr. Ali",
    room: "Room 307",
    startTime: "01:30 PM",
    endTime: "03:00 PM",
    day: "Monday",
    color: Color(0xffF59E0B),
  ),

  TimetableModel(
    subject: "Artificial Intelligence",
    instructor: "Dr. Bilal",
    room: "AI Lab",
    startTime: "03:30 PM",
    endTime: "05:00 PM",
    day: "Monday",
    color: Color(0xff8B5CF6),
  ),
];