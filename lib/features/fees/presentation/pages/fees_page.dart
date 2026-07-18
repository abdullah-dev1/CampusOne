import 'package:flutter/material.dart';
import '../../data/mock/mock_fees.dart';
import '../widgets/fee_summary_card.dart';
import '../widgets/fee_item_card.dart';
import '../widgets/payment_history_card.dart';
import '../widgets/payment_button.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final total = feeList.fold<double>(
      0,
      (sum, item) => sum + item.amount,
    );
    final paid = feeList.where((e) => e.isPaid).fold<double>(
          0,
          (sum, item) => sum + item.amount,
        );

    return Scaffold(
      backgroundColor: const Color(0xffF4F7FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Fees",
          style: TextStyle(
            color: Color(0xff0F172A),
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: -.3,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xff0F172A),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          20,
          14,
          20,
          30,
        ),
        children: [
          FeeSummaryCard(
            totalFee: total,
            paidFee: paid,
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              const Text(
                "Fee Breakdown",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff2563EB).withOpacity(.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xff2563EB).withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.receipt_long_rounded,
                      color: Color(0xff2563EB),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${feeList.length} Items",
                      style: const TextStyle(
                        color: Color(0xff2563EB),
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...feeList.map(
            (fee) => FeeItemCard(
              fee: fee,
            ),
          ),

          const SizedBox(height: 32),

          Row(
            children: [
              const Text(
                "Payment History",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff22C55E).withOpacity(.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xff22C55E).withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: const Text(
                  "Recent",
                  style: TextStyle(
                    color: Color(0xff16A34A),
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const PaymentHistoryCard(
            title: "Spring 2026",
            date: "15 Jan 2026",
            amount: "Rs. 45,000",
          ),
          const PaymentHistoryCard(
            title: "Fall 2025",
            date: "18 Aug 2025",
            amount: "Rs. 42,500",
          ),
          const PaymentHistoryCard(
            title: "Spring 2025",
            date: "12 Jan 2025",
            amount: "Rs. 40,000",
          ),

          const SizedBox(height: 32),

          PaymentButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    "Online payment integration coming soon.",
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: const Color(0xff0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}