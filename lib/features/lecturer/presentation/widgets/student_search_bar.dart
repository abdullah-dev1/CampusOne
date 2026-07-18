import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/lecturer_students_provider.dart';

class StudentSearchBar extends StatelessWidget {
  const StudentSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        context
            .read<LecturerStudentsProvider>()
            .searchStudent(value);
      },
      decoration: InputDecoration(
        hintText: "Search Student...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}