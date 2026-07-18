import 'package:flutter/material.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';
import '../../domain/repository/notice_repository.dart';

class NoticeManagementProvider extends ChangeNotifier {
  NoticeManagementProvider(
    this._repository,
  );

  final NoticeRepository _repository;

  final List<NoticeModel> _notices = [];

  List<NoticeModel> _filteredNotices = [];

  bool _isLoading = false;

  String _searchQuery = "";

  String _selectedCategory = "All";

  String _selectedStatus = "All";


  bool get isLoading => _isLoading;


  List<NoticeModel> get notices =>
      List.unmodifiable(_notices);


  List<NoticeModel> get filteredNotices =>
      List.unmodifiable(_filteredNotices);


  String get selectedCategory =>
      _selectedCategory;


  String get selectedStatus =>
      _selectedStatus;



  // ==========================
  // LOAD
  // ==========================

  Future<void> loadNotices() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data =
          await _repository.getNotices();

      _notices
        ..clear()
        ..addAll(data);

      _applyFilters();

    } finally {

      _isLoading = false;
      notifyListeners();

    }
  }



  // ==========================
  // ADD
  // ==========================

  Future<void> addNotice(
    NoticeModel notice,
  ) async {

    await _repository.addNotice(notice);

    await loadNotices();

  }



  // ==========================
  // UPDATE
  // ==========================

  Future<void> updateNotice(
    NoticeModel notice,
  ) async {

    await _repository.updateNotice(notice);

    await loadNotices();

  }



  // ==========================
  // DELETE
  // ==========================

  Future<void> deleteNotice(
    String id,
  ) async {

    await _repository.deleteNotice(id);

    await loadNotices();

  }



  Future<void> deleteSelected(
    List<String> ids,
  ) async {

    await _repository.deleteSelectedNotices(ids);

    await loadNotices();

  }



  // ==========================
  // PIN
  // ==========================

  Future<void> togglePinned(
    NoticeModel notice,
  ) async {

    await _repository.togglePinned(
      notice.id,
      !notice.isPinned,
    );

    await loadNotices();

  }



  // ==========================
  // STATUS
  // ==========================

  Future<void> changeStatus(
    NoticeModel notice,
    NoticeStatus status,
  ) async {

    await _repository.changeStatus(
      notice.id,
      status,
    );

    await loadNotices();

  }



  // ==========================
  // SEARCH
  // ==========================

  void search(
    String value,
  ) {

    _searchQuery = value.trim();

    _applyFilters();

  }


  // Compatibility method
  // Used by NoticeFilters widget

  void searchNotices(
    String value,
  ) {

    search(value);

  }



  // ==========================
  // CATEGORY
  // ==========================

  void filterCategory(
    String value,
  ) {

    _selectedCategory = value;

    _applyFilters();

  }



  // ==========================
  // STATUS FILTER
  // ==========================

  void filterStatus(
    String value,
  ) {

    _selectedStatus = value;

    _applyFilters();

  }



  // ==========================
  // RESET
  // ==========================

  void clearFilters() {

    _searchQuery = "";

    _selectedCategory = "All";

    _selectedStatus = "All";

    _applyFilters();

  }



  // ==========================
  // FILTERING
  // ==========================

  void _applyFilters() {

    List<NoticeModel> list =
        List.from(_notices);



    if (_searchQuery.isNotEmpty) {

      final query =
          _searchQuery.toLowerCase();


      list = list.where((notice) {

        return notice.title
                .toLowerCase()
                .contains(query) ||

            notice.description
                .toLowerCase()
                .contains(query) ||

            notice.createdBy
                .toLowerCase()
                .contains(query);

      }).toList();

    }



    if (_selectedCategory != "All") {

      list = list.where((notice) {

        return notice.category.name ==
            _selectedCategory.toLowerCase();

      }).toList();

    }



    if (_selectedStatus != "All") {

      list = list.where((notice) {

        return notice.status.name ==
            _selectedStatus.toLowerCase();

      }).toList();

    }



    list.sort((a, b) {

      if (a.isPinned != b.isPinned) {

        return a.isPinned ? -1 : 1;

      }


      return b.createdAt.compareTo(
        a.createdAt,
      );

    });



    _filteredNotices = list;

    notifyListeners();

  }



  // ==========================
  // DASHBOARD
  // ==========================

  int get totalNotices =>
      _notices.length;



  int get pinnedCount =>
      _notices
          .where((e) => e.isPinned)
          .length;



  int get publishedCount =>
      _notices
          .where(
            (e) =>
                e.status ==
                NoticeStatus.published,
          )
          .length;



  int get draftCount =>
      _notices
          .where(
            (e) =>
                e.status ==
                NoticeStatus.draft,
          )
          .length;



  int get archivedCount =>
      _notices
          .where(
            (e) =>
                e.status ==
                NoticeStatus.archived,
          )
          .length;



  Map<String, int> get categoryStats {

    final Map<String, int> map = {};


    for (final notice in _notices) {

      final key = notice.category.name;


      map[key] =
          (map[key] ?? 0) + 1;

    }


    return map;

  }



  // ==========================
  // COMPATIBILITY GETTERS
  // ==========================


  List<NoticeModel> get pinnedNotices {

    return _notices
        .where(
          (notice) => notice.isPinned,
        )
        .toList();

  }



  Map<String, int> get noticesByCategory {

    return categoryStats;

  }

}