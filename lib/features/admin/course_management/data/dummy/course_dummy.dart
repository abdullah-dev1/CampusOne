import '../models/course_model.dart';

class CourseDummyData {
  static final DateTime _seedDate = DateTime(2026, 1, 1);

  static List<CourseModel> courses = [
    CourseModel(
      id: '1',
      courseCode: 'CS1001',
      courseTitle: 'Programming Fundamentals',
      department: 'BS Computer Science',
      semester: '1',
      creditHours: 3,
      type: CourseType.core,
      description: 'Introduction to programming using C++.',
      prerequisites: const [],
      assignedLecturer: 'Dr. Ali Raza',
      assignedSections: const [
        'BSCS-1A',
        'BSCS-1B',
      ],
      totalStudents: 82,
      createdAt: _seedDate,
      updatedAt: _seedDate,
    ),
    CourseModel(
      id: '2',
      courseCode: 'CS2001',
      courseTitle: 'Object Oriented Programming',
      department: 'BS Computer Science',
      semester: '2',
      creditHours: 3,
      type: CourseType.core,
      description: 'Classes, Objects and OOP concepts.',
      prerequisites: const [
        'Programming Fundamentals',
      ],
      assignedLecturer: 'Dr. Ahmad Khan',
      assignedSections: const [
        'BSCS-2A',
      ],
      totalStudents: 43,
      createdAt: _seedDate,
      updatedAt: _seedDate,
    ),
    CourseModel(
      id: '3',
      courseCode: 'CS3002',
      courseTitle: 'Data Structures',
      department: 'BS Computer Science',
      semester: '3',
      creditHours: 4,
      type: CourseType.core,
      description: 'Linear and Non-Linear Data Structures.',
      prerequisites: const [
        'Object Oriented Programming',
      ],
      assignedLecturer: 'Dr. Umar Farooq',
      assignedSections: const [
        'BSCS-3A',
        'BSCS-3B',
      ],
      totalStudents: 88,
      createdAt: _seedDate,
      updatedAt: _seedDate,
    ),
    CourseModel(
      id: '4',
      courseCode: 'SE3005',
      courseTitle: 'Software Engineering',
      department: 'BS Software Engineering',
      semester: '5',
      creditHours: 3,
      type: CourseType.core,
      description: 'Software Development Life Cycle.',
      prerequisites: const [
        'Object Oriented Programming',
      ],
      assignedLecturer: 'Dr. Hassan',
      assignedSections: const [
        'BSSE-5A',
      ],
      totalStudents: 48,
      createdAt: _seedDate,
      updatedAt: _seedDate,
    ),
    CourseModel(
      id: '5',
      courseCode: 'AI4002',
      courseTitle: 'Machine Learning',
      department: 'BS Artificial Intelligence',
      semester: '6',
      creditHours: 3,
      type: CourseType.elective,
      description: 'Introduction to Machine Learning.',
      prerequisites: const [
        'Probability',
        'Linear Algebra',
      ],
      assignedLecturer: 'Dr. Saad',
      assignedSections: const [
        'BSAI-6A',
      ],
      totalStudents: 39,
      createdAt: _seedDate,
      updatedAt: _seedDate,
    ),
  ];
}
