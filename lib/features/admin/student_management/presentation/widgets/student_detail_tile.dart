import 'package:flutter/material.dart';

class StudentDetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StudentDetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      title: Text(title),
      subtitle: Text(
        value.isEmpty ? "-" : value,
      ),
    );
  }
}