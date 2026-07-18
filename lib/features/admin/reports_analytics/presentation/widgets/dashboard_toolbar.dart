import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/reports_analytics_provider.dart';

class DashboardToolbar extends StatelessWidget {
  const DashboardToolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ReportsAnalyticsProvider>();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Text(
                  "Last Updated",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  DateFormat(
                    "dd MMM yyyy • hh:mm a",
                  ).format(
                    provider.lastUpdated,
                  ),
                ),

              ],
            ),
          ),

          ElevatedButton.icon(
            onPressed: provider.isRefreshing
                ? null
                : () {
                    provider.refreshDashboard();
                  },
            icon: provider.isRefreshing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.refresh,
                  ),
            label: Text(
              provider.isRefreshing
                  ? "Refreshing..."
                  : "Refresh",
            ),
          ),

        ],
      ),
    );
  }
}