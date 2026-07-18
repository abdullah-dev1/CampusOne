import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lecturer_management_provider.dart';
import '../../domain/repository/lecturer_repository.dart';
import '../../../../../../core/services/service_locator.dart';
import '../widgets/lecturer_header.dart';
import '../widgets/lecturer_statistics.dart';
import '../widgets/lecturer_filters.dart';
import '../widgets/lecturer_card.dart';

class LecturerManagementPage extends StatelessWidget {
  const LecturerManagementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LecturerManagementProvider(
      locator<LecturerRepository>(),
),
      child: Consumer<LecturerManagementProvider>(
        builder: (context, provider, child) {

          return Scaffold(
            backgroundColor:
                const Color(0xffF8FAFC),

            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Lecturer Management",
              ),
            ),

            body: SafeArea(
              child: ListView(
                padding:
                    const EdgeInsets.all(20),

                children: [

                  const LecturerHeader(),

                  const SizedBox(height: 24),

                  const LecturerStatistics(),

                  const SizedBox(height: 24),

                  const LecturerFilters(),

                  const SizedBox(height: 24),

                  if (provider.filteredLecturers.isEmpty)

                    Container(
                      padding:
                          const EdgeInsets.all(40),

                      child: const Center(
                        child: Text(
                          "No lecturers found.",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )

                  else

                    ...provider.filteredLecturers.map(

                      (lecturer) =>
                          LecturerCard(
                        lecturer: lecturer,
                      ),

                    ),

                  const SizedBox(height: 30),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}