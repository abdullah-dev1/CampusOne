import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campusone/features/notices/data/models/notice_model.dart';

class NoticeProvider extends ChangeNotifier {
   List<NoticeModel> notices = [];

  String searchQuery = "";
  String selectedPriority = "All";

  /// ==========================
  /// Filters
  /// ==========================

  List<NoticeModel> get filteredNotices {


    List<NoticeModel> filtered = List.from(notices);
NoticeProvider(){
  fetchNotices();
}
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((notice) {
        return notice.title
                .toLowerCase()
                .contains(searchQuery) ||
            notice.description
                .toLowerCase()
                .contains(searchQuery);
      }).toList();
    }

    if (selectedPriority != "All") {
      filtered = filtered.where((notice) {
        return notice.priority.name ==
            selectedPriority.toLowerCase();
      }).toList();
    }

    filtered.sort((a, b) {
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
    });

    return filtered;
  }
void fetchNotices(){

  FirebaseFirestore.instance
      .collection("notices")
      .snapshots()
      .listen((snapshot){

    notices = snapshot.docs.map((doc){

      final data = doc.data();

      data["id"] = doc.id;

      return NoticeModel.fromMap(data);

    }).toList();


    notifyListeners();

  });

}
  void searchNotice(String value) {
    searchQuery = value.trim().toLowerCase();
    notifyListeners();
  }

  void changePriority(String value) {
    selectedPriority = value;
    notifyListeners();
  }

  /// ==========================
  /// CRUD
  /// ==========================

  void addNotice(NoticeModel notice) {
    notices.insert(0, notice);
    notifyListeners();
  }

  void updateNotice(NoticeModel updatedNotice) {
    final index = notices.indexWhere(
      (notice) => notice.id == updatedNotice.id,
    );

    if (index != -1) {
      notices[index] = updatedNotice;
      notifyListeners();
    }
  }

  void deleteNotice(String id) {
    notices.removeWhere(
      (notice) => notice.id == id,
    );

    notifyListeners();
  }

  /// ==========================
  /// Pin / Publish
  /// ==========================

  void togglePin(String id) {
    final index = notices.indexWhere(
      (notice) => notice.id == id,
    );

    if (index != -1) {
     notices[index] =
    notices[index].copyWith(
      status:
      notices[index].status ==
      NoticeStatus.published
          ? NoticeStatus.draft
          : NoticeStatus.published,
    );
      notifyListeners();
    }
  }

  void togglePublish(String id) {
    final index = notices.indexWhere(
      (notice) => notice.id == id,
    );

    if (index != -1) {
    notices[index] = notices[index].copyWith(
  status: notices[index].status == NoticeStatus.published
      ? NoticeStatus.draft
      : NoticeStatus.published,
);

      notifyListeners();
    }
  }

  /// ==========================
  /// Statistics
  /// ==========================

  int get totalNotices => notices.length;

  int get publishedNotices =>
      notices.where(
  (e) => e.status == NoticeStatus.published,
).length;

  int get pinnedNotices =>
      notices.where((e) => e.isPinned).length;

  int get highPriorityNotices =>
      notices
          .where(
            (e) =>
                e.priority ==
                NoticePriority.high,
          )
          .length;
}