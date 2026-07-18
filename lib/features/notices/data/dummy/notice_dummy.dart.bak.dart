import 'package:campusone/features/notices/data/models/notice_model.dart';

List<NoticeModel> dummyNotices = [

  NoticeModel(
    id: "1",
    title: "Mid Exam Schedule",
    description:
        "Mid examinations will begin from 15 August.\n\nVenue: CS Block\nTime: 9:00 AM",
    postedBy: "Admin",
    postedDate: "12 Jul 2026",
    expiryDate: "20 Aug 2026",
    priority: NoticePriority.high,
    isPinned: true,
  ),

  NoticeModel(
    id: "2",
    title: "Fee Submission Deadline",
    description:
        "All students are requested to submit semester fee before 25 July.",
    postedBy: "Admin",
    postedDate: "10 Jul 2026",
    expiryDate: "25 Jul 2026",
    priority: NoticePriority.high,
    isPinned: true,
  ),

  NoticeModel(
    id: "3",
    title: "Guest Lecture",
    description:
        "AI Research Seminar will be conducted in Auditorium A on Friday.",
    postedBy: "Admin",
    postedDate: "09 Jul 2026",
    expiryDate: "18 Jul 2026",
    priority: NoticePriority.medium,
  ),

  NoticeModel(
    id: "4",
    title: "Library Timing Updated",
    description:
        "Library will remain open from 8:00 AM to 10:00 PM.",
    postedBy: "Admin",
    postedDate: "08 Jul 2026",
    expiryDate: "31 Dec 2026",
    priority: NoticePriority.low,
  ),

  NoticeModel(
    id: "5",
    title: "Semester Registration",
    description:
        "Registration portal will open from 1 August. Students must complete registration before the deadline.",
    postedBy: "Admin",
    postedDate: "07 Jul 2026",
    expiryDate: "15 Aug 2026",
    priority: NoticePriority.high,
  ),

];