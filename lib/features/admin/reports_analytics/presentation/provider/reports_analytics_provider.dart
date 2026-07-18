import 'package:flutter/material.dart';

enum AnalyticsFilter {
  today,
  week,
  month,
  year,
}

class ReportsAnalyticsProvider
    extends ChangeNotifier {

  AnalyticsFilter _selectedFilter =
      AnalyticsFilter.month;

  AnalyticsFilter get selectedFilter =>
      _selectedFilter;

  DateTime _lastUpdated =
      DateTime.now();

  DateTime get lastUpdated =>
      _lastUpdated;

  bool _isRefreshing = false;

  bool get isRefreshing =>
      _isRefreshing;

  void changeFilter(
    AnalyticsFilter filter,
  ) {
    if (_selectedFilter == filter) {
      return;
    }

    _selectedFilter = filter;

    notifyListeners();
  }

  Future<void> refreshDashboard() async {
    _isRefreshing = true;

    notifyListeners();

    await Future.delayed(
      const Duration(
        milliseconds: 1200,
      ),
    );

    _lastUpdated = DateTime.now();

    _isRefreshing = false;

    notifyListeners();
  }
}