import 'package:flutter/material.dart';

class AssignmentFilterTabs extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onChanged;

  const AssignmentFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  static const filters = [
    "All",
    "Pending",
    "Submitted",
    "Late",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return GestureDetector(
            onTap: () => onChanged(filter),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              scale: isSelected ? 1.04 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            Color(0xff2563EB),
                            Color(0xff3B82F6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xff2563EB).withOpacity(.32),
                            blurRadius: 20,
                            offset: const Offset(0, 9),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(.03),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xff475569),
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}