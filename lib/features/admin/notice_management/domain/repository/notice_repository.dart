import 'package:campusone/features/notices/data/models/notice_model.dart';
abstract class NoticeRepository {

  Future<List<NoticeModel>> getNotices();


  Future<void> addNotice(
    NoticeModel notice,
  );


  Future<void> updateNotice(
    NoticeModel notice,
  );


  Future<void> deleteNotice(
    String id,
  );


  Future<void> deleteSelectedNotices(
    List<String> ids,
  );


  Future<void> togglePinned(
    String id,
    bool value,
  );


  Future<void> changeStatus(
    String id,
    NoticeStatus status,
  );

}