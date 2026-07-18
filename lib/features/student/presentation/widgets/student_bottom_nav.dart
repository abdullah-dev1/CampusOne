import 'package:flutter/material.dart';

class StudentBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const StudentBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.home_rounded,
        label: "Home",
      ),
      (
        icon: Icons.calendar_month_rounded,
        label: "Timetable",
      ),
      (
        icon: Icons.notifications_rounded,
        label: "Alerts",
      ),
      (
        icon: Icons.person_rounded,
        label: "Profile",
      ),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff2563EB).withOpacity(.10),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            items.length,
            (index) {
              final selected = currentIndex == index;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  splashColor: const Color(0xff2563EB).withOpacity(0.08),
                  highlightColor: const Color(0xff2563EB).withOpacity(0.04),
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: selected
                          ? LinearGradient(
                              colors: [
                                const Color(0xff2563EB).withOpacity(.14),
                                const Color(0xff2563EB).withOpacity(.07),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: selected ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      border: selected
                          ? Border.all(
                              color: const Color(0xff2563EB).withOpacity(0.12),
                              width: 1,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          scale: selected ? 1.15 : 1,
                          child: Icon(
                            items[index].icon,
                            color: selected
                                ? const Color(0xff2563EB)
                                : Colors.grey.shade400,
                            size: 25,
                          ),
                        ),
                        const SizedBox(height: 5),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: selected
                              ? Container(
                                  key: const ValueKey("dot"),
                                  height: 4,
                                  width: 4,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xff2563EB),
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : const SizedBox(
                                  key: ValueKey("no-dot"),
                                  height: 4,
                                  width: 4,
                                ),
                        ),
                        Text(
                          items[index].label,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected
                                ? const Color(0xff2563EB)
                                : Colors.grey.shade600,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}