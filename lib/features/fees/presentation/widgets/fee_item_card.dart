import 'package:flutter/material.dart';

import '../../data/models/fee_model.dart';

class FeeItemCard extends StatelessWidget {
  final FeeModel fee;

  const FeeItemCard({
    super.key,
    required this.fee,
  });

  @override
  Widget build(BuildContext context) {
    final bool paid = fee.isPaid;
    final Color statusColor =
        paid ? const Color(0xff22C55E) : const Color(0xffF59E0B);

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: statusColor.withOpacity(.25),
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(.07),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      statusColor.withOpacity(.16),
                      statusColor.withOpacity(.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  paid
                      ? Icons.check_circle_rounded
                      : Icons.receipt_long_rounded,
                  color: statusColor,
                  size: 26,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fee.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Due: ${fee.dueDate}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: statusColor.withOpacity(0.18),
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
                        color: paid
                            ? const Color(0xff16A34A)
                            : const Color(0xffD97706),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      paid ? "Paid" : "Pending",
                      style: TextStyle(
                        color: paid
                            ? const Color(0xff16A34A)
                            : const Color(0xffD97706),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            height: 1,
            color: Colors.grey.shade100,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Text(
                "Amount",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.1,
                ),
              ),
              const Spacer(),
              Text(
                "Rs. ${fee.amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff2563EB),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}