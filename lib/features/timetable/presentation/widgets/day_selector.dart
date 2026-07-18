import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final String selectedDay;
  final ValueChanged<String> onDaySelected;

  const DaySelector({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  static const List<String> days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = day == selectedDay;

          return GestureDetector(
            onTap: () => onDaySelected(day),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack,
              scale: isSelected ? 1.04 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
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
                            blurRadius: 22,
                            offset: const Offset(0, 10),
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
                    day,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xff334155),
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
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