import '../models/department_model.dart';

class DepartmentDummyData {
  static List<DepartmentModel> departments = [

    DepartmentModel(
      id: "1",
      departmentCode: "CS",
      departmentName: "Computer Science",
      description:
          "Department of Computer Science offering undergraduate and postgraduate programs.",
      headOfDepartment: "Dr. Ahmad Raza",
      facultyCount: 28,
      studentCount: 620,
      courseCount: 42,
      officeLocation: "Block A - First Floor",
      phone: "+92-41-1234567",
      email: "cs@university.edu.pk",
      status: DepartmentStatus.active,
    ),

    DepartmentModel(
      id: "2",
      departmentCode: "SE",
      departmentName: "Software Engineering",
      description:
          "Department focused on software development, software architecture, and engineering practices.",
      headOfDepartment: "Dr. Muhammad Ali",
      facultyCount: 21,
      studentCount: 470,
      courseCount: 36,
      officeLocation: "Block B - Second Floor",
      phone: "+92-41-1234568",
      email: "se@university.edu.pk",
      status: DepartmentStatus.active,
    ),

    DepartmentModel(
      id: "3",
      departmentCode: "AI",
      departmentName: "Artificial Intelligence",
      description:
          "Department specializing in Artificial Intelligence, Machine Learning, and Data Science.",
      headOfDepartment: "Dr. Sarah Khan",
      facultyCount: 18,
      studentCount: 360,
      courseCount: 30,
      officeLocation: "Block C - First Floor",
      phone: "+92-41-1234569",
      email: "ai@university.edu.pk",
      status: DepartmentStatus.active,
    ),

    DepartmentModel(
      id: "4",
      departmentCode: "CY",
      departmentName: "Cyber Security",
      description:
          "Department dedicated to cyber security, ethical hacking, and digital forensics.",
      headOfDepartment: "Dr. Usman Tariq",
      facultyCount: 15,
      studentCount: 240,
      courseCount: 24,
      officeLocation: "Block C - Ground Floor",
      phone: "+92-41-1234570",
      email: "cyber@university.edu.pk",
      status: DepartmentStatus.active,
    ),

    DepartmentModel(
      id: "5",
      departmentCode: "DS",
      departmentName: "Data Science",
      description:
          "Department offering programs in data analytics, statistics, and big data technologies.",
      headOfDepartment: "Dr. Ayesha Noor",
      facultyCount: 12,
      studentCount: 190,
      courseCount: 20,
      officeLocation: "Block D - First Floor",
      phone: "+92-41-1234571",
      email: "datascience@university.edu.pk",
      status: DepartmentStatus.inactive,
    ),

  ];
}