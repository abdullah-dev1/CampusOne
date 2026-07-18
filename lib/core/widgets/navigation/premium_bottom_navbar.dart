import 'package:flutter/material.dart';

class PremiumBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PremiumBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: Container(
        height: 76,
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
              blurRadius: 34,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              index: 0,
              currentIndex: currentIndex,
              icon: Icons.home_rounded,
              label: "Home",
              onTap: onTap,
            ),
            _NavItem(
              index: 1,
              currentIndex: currentIndex,
              icon: Icons.calendar_month_rounded,
              label: "Timetable",
              onTap: onTap,
            ),
            _NavItem(
              index: 2,
              currentIndex: currentIndex,
              icon: Icons.notifications_rounded,
              label: "Alerts",
              onTap: onTap,
            ),
            _NavItem(
              index: 3,
              currentIndex: currentIndex,
              icon: Icons.person_rounded,
              label: "Profile",
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      splashColor: const Color(0xff2563EB).withOpacity(0.08),
      highlightColor: const Color(0xff2563EB).withOpacity(0.04),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 18 : 12,
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
                  color: const Color(0xff2563EB).withOpacity(.12),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutBack,
              scale: selected ? 1.1 : 1.0,
              child: Icon(
                icon,
                color: selected
                    ? const Color(0xff2563EB)
                    : Colors.grey.shade400,
                size: 24,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              child: selected
                  ? Row(
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Color(0xff2563EB),
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(width: 0),
            ),
          ],
        ),
      ),
    );
  }
}