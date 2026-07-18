import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../admin/student_management/data/models/student_model.dart';
import '../provider/lecturer_provider.dart';
import '../provider/lecturer_students_provider.dart';

import '../widgets/student_card.dart';
import '../widgets/student_search_bar.dart';
import '../widgets/student_statistics.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final lecturerProvider =
        context.read<LecturerProvider>();

    if (lecturerProvider.lecturer != null) {
      context
          .read<LecturerStudentsProvider>()
          .initialize(lecturerProvider);

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        title: const Text(
          "Students",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontWeight: FontWeight.w800,
            fontSize: 21,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xff0F172A),
        ),
      ),

      body: Consumer<LecturerStudentsProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),

              children: [

                const StudentSearchBar(),

                const SizedBox(height: 20),

                StudentStatistics(
                  totalStudents:
                      provider.totalStudents,
                  section: "Assigned Sections",
                ),

                const SizedBox(height: 28),

                Row(
                  children: [

                    Container(
                      height: 36,
                      width: 36,

                      decoration: BoxDecoration(
                        color: const Color(0xff2563EB)
                            .withOpacity(.10),

                        borderRadius:
                            BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.groups,
                        color: Color(0xff2563EB),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      "Student List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xff2563EB)
                            .withOpacity(.10),

                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: Text(
                        "${provider.filteredStudents.length} Students",
                        style: const TextStyle(
                          color: Color(0xff2563EB),
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 18),

                if (provider.filteredStudents.isEmpty)

                  const Padding(
                    padding:
                        EdgeInsets.only(top: 80),

                    child: Center(
                      child: Text(
                        "No students found.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )

                else

                  ...provider.filteredStudents.map(

                    (StudentModel student) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),

                      child: StudentCard(
                        student: student,
                      ),
                    ),

                  ),

              ],
            ),
          );
        },
      ),
    );
  }
}