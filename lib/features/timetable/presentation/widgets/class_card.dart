import 'package:flutter/material.dart';

import '../../data/models/timetable_model.dart';

class ClassCard extends StatelessWidget {
  final TimetableModel timetable;
  final bool isCurrentClass;

  const ClassCard({
    super.key,
    required this.timetable,
    this.isCurrentClass = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCurrentClass
              ? timetable.color.withOpacity(.45)
              : Colors.grey.shade200,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: timetable.color.withOpacity(.09),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  timetable.color,
                  timetable.color.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        timetable.subject,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0F172A),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    if (isCurrentClass)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff22C55E).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xff22C55E).withOpacity(0.25),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                color: const Color(0xff22C55E),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff22C55E)
                                        .withOpacity(0.6),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "LIVE",
                              style: TextStyle(
                                color: Color(0xff16A34A),
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        timetable.instructor,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey.shade600,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        timetable.room,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            timetable.color.withOpacity(.14),
                            timetable.color.withOpacity(.07),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 16,
                            color: timetable.color,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${timetable.startTime} - ${timetable.endTime}",
                            style: TextStyle(
                              color: timetable.color,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.5,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            timetable.color.withOpacity(.16),
                            timetable.color.withOpacity(.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 17,
                        color: timetable.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}