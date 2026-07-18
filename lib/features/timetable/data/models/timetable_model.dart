import 'package:flutter/material.dart';

class TimetableModel {
  final String subject;
  final String instructor;
  final String room;
  final String startTime;
  final String endTime;
  final String day;
  final Color color;

  const TimetableModel({
    required this.subject,
    required this.instructor,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.color,
  });
}