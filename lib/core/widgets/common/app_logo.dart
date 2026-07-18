import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double logoSize;
  final bool showTitle;
  final Color textColor;

  const AppLogo({
  super.key,
  this.logoSize = 90,
  this.showTitle = true,
  this.textColor = const Color(0xFF0F172A),
});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Image.asset(
          "assets/logos/campusone_logo.png",
          width: logoSize,
          height: logoSize,
        ),

        if (showTitle) ...[

          const SizedBox(height: 18),

          Text(
  "CampusOne",
  style: TextStyle(
    color: textColor,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
    height: 1.1,
  ),
),

const SizedBox(height: 8),

Text(
  "Smart Campus Management",
  style: TextStyle(
    color: textColor.withOpacity(.7),
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
  ),
),
        ]
      ],
    );
  }
}