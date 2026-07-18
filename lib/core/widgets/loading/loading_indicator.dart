import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 44,
        width: 44,
        child: CircularProgressIndicator(
          strokeWidth: 3.2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E4AF2)),
        ),
      ),
    );
  }
}