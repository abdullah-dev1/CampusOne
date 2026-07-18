import 'package:campusone/features/notices/data/models/notice_model.dart';
class NoticeDummyData {
  static List<NoticeModel> notices = [
    NoticeModel(
      id: "N001",
      title: "Mid Semester Examination Schedule",
      description:
          "Mid semester examinations will begin from 15 September. Students are advised to check the portal for detailed date sheets.",
      category: NoticeCategory.examination,
      target: NoticeTarget.students,
      priority: NoticePriority.high,
      status: NoticeStatus.published,
      publishDate: "10 Sep 2026",
      expiryDate: "20 Sep 2026",
      createdBy: "Examination Office",
      isPinned: true,
    ),

    NoticeModel(
      id: "N002",
      title: "Merit Scholarship Announcement",
      description:
          "Applications for merit scholarships are now open. Eligible students should apply before the deadline.",
      category: NoticeCategory.scholarship,
      target: NoticeTarget.students,
      priority: NoticePriority.high,
      status: NoticeStatus.published,
      publishDate: "08 Sep 2026",
      expiryDate: "30 Sep 2026",
      createdBy: "Financial Aid Office",
    ),

    NoticeModel(
      id: "N003",
      title: "AI Workshop 2026",
      description:
          "Department of Artificial Intelligence is organizing a hands-on AI Workshop for all students.",
      category: NoticeCategory.events,
      target: NoticeTarget.all,
      priority: NoticePriority.normal,
      status: NoticeStatus.published,
      publishDate: "05 Sep 2026",
      expiryDate: "18 Sep 2026",
      createdBy: "AI Department",
    ),

    NoticeModel(
      id: "N004",
      title: "Hostel Fee Submission",
      description:
          "All hostel residents are instructed to submit hostel dues before the due date.",
      category: NoticeCategory.hostel,
      target: NoticeTarget.students,
      priority: NoticePriority.normal,
      status: NoticeStatus.published,
      publishDate: "06 Sep 2026",
      expiryDate: "25 Sep 2026",
      createdBy: "Hostel Administration",
    ),

    NoticeModel(
      id: "N005",
      title: "Faculty Meeting",
      description:
          "Monthly faculty meeting will be held in the seminar hall at 2 PM.",
      category: NoticeCategory.academic,
      target: NoticeTarget.lecturers,
      priority: NoticePriority.normal,
      status: NoticeStatus.draft,
      publishDate: "12 Sep 2026",
      expiryDate: "12 Sep 2026",
      createdBy: "Dean Office",
    ),

    NoticeModel(
      id: "N006",
      title: "Admissions Open",
      description:
          "Admissions for Spring 2027 are officially open across all departments.",
      category: NoticeCategory.admission,
      target: NoticeTarget.all,
      priority: NoticePriority.high,
      status: NoticeStatus.published,
      publishDate: "01 Sep 2026",
      expiryDate: "31 Oct 2026",
      createdBy: "Admission Office",
    ),

    NoticeModel(
      id: "N007",
      title: "University Closed on Independence Day",
      description:
          "University will remain closed on 14 August due to Independence Day.",
      category: NoticeCategory.holiday,
      target: NoticeTarget.all,
      priority: NoticePriority.normal,
      status: NoticeStatus.published,
      publishDate: "10 Aug 2026",
      expiryDate: "14 Aug 2026",
      createdBy: "Administration",
    ),

    NoticeModel(
      id: "N008",
      title: "Emergency Water Shutdown",
      description:
          "Water supply will remain suspended from 10 AM to 4 PM because of maintenance work.",
      category: NoticeCategory.emergency,
      target: NoticeTarget.all,
      priority: NoticePriority.urgent,
      status: NoticeStatus.published,
      publishDate: "09 Sep 2026",
      expiryDate: "09 Sep 2026",
      createdBy: "Campus Maintenance",
      isPinned: true,
    ),

    NoticeModel(
      id: "N009",
      title: "Inter-University Sports Gala",
      description:
          "Students interested in participating should register before Friday.",
      category: NoticeCategory.sports,
      target: NoticeTarget.students,
      priority: NoticePriority.normal,
      status: NoticeStatus.published,
      publishDate: "07 Sep 2026",
      expiryDate: "18 Sep 2026",
      createdBy: "Sports Department",
    ),

    NoticeModel(
      id: "N010",
      title: "General Staff Meeting",
      description:
          "Monthly administrative meeting for department coordinators.",
      category: NoticeCategory.general,
      target: NoticeTarget.departments,
      priority: NoticePriority.low,
      status: NoticeStatus.archived,
      publishDate: "01 Aug 2026",
      expiryDate: "01 Aug 2026",
      createdBy: "Registrar Office",
    ),
  ];
}