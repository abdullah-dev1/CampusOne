import 'package:flutter/material.dart';

class AssignmentModel {
  final String id;
  final String title;
  final String subject;
  final String lecturer;
  final String dueDate;
  final int remainingDays;
  final bool submitted;
  final bool late;
  final double progress;
  final Color color;

  const AssignmentModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.lecturer,
    required this.dueDate,
    required this.remainingDays,
    required this.submitted,
    required this.late,
    required this.progress,
    required this.color,
  });
}