import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../notices/data/models/notice_model.dart';
import '../../domain/repository/notice_repository.dart';

class FirebaseNoticeRepository implements NoticeRepository {
  final FirebaseFirestore _firestore;

  FirebaseNoticeRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  static const String _collection = "notices";

  CollectionReference<Map<String, dynamic>> get _noticeCollection =>
      _firestore.collection(_collection);

  @override
  Future<List<NoticeModel>> getNotices() async {
    try {
      final snapshot = await _noticeCollection
          .orderBy(
            "createdAt",
            descending: true,
          )
          .get();

      return snapshot.docs.map((doc) {
        return NoticeModel.fromMap({
          ...doc.data(),
          "id": doc.id,
        });
      }).toList();
    } catch (e) {
      throw Exception("Failed to load notices: $e");
    }
  }

  @override
  Future<void> addNotice(
    NoticeModel notice,
  ) async {
    try {
      final document = _noticeCollection.doc();

      final newNotice = notice.copyWith(
  id: document.id,
  updatedAt: DateTime.now(),
);

      await document.set(
        newNotice.toMap(),
      );
    } catch (e) {
      throw Exception("Failed to add notice: $e");
    }
  }

  @override
  Future<void> updateNotice(
    NoticeModel notice,
  ) async {
    try {
      await _noticeCollection
          .doc(notice.id)
          .update(
            notice.copyWith(
              updatedAt: DateTime.now(),
            ).toMap(),
          );
    } catch (e) {
      throw Exception("Failed to update notice: $e");
    }
  }

  @override
  Future<void> deleteNotice(
    String noticeId,
  ) async {
    try {
      await _noticeCollection
          .doc(noticeId)
          .delete();
    } catch (e) {
      throw Exception("Failed to delete notice: $e");
    }
  }

  @override
  Future<void> deleteSelectedNotices(
    List<String> ids,
  ) async {
    try {
      final batch = _firestore.batch();

      for (final id in ids) {
        batch.delete(
          _noticeCollection.doc(id),
        );
      }

      await batch.commit();
    } catch (e) {
      throw Exception("Failed to delete selected notices: $e");
    }
  }

  @override
  Future<void> changeStatus(
    String noticeId,
    NoticeStatus status,
  ) async {
    try {
      await _noticeCollection
          .doc(noticeId)
          .update({
        "status": status.name,
        "updatedAt": Timestamp.now(),
      });
    } catch (e) {
      throw Exception("Failed to change status: $e");
    }
  }

  @override
  Future<void> togglePinned(
    String noticeId,
    bool isPinned,
  ) async {
    try {
      await _noticeCollection
          .doc(noticeId)
          .update({
        "isPinned": isPinned,
        "updatedAt": Timestamp.now(),
      });
    } catch (e) {
      throw Exception("Failed to pin notice: $e");
    }
  }
}