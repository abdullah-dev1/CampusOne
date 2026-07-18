import 'package:cloud_firestore/cloud_firestore.dart';


enum NoticeCategory {
  general,
  academic,
  event,
  emergency,
}


enum NoticeTarget {
  all,
  students,
  lecturers,
}


enum NoticePriority {
  low,
  normal,
  high,
  urgent,
}


enum NoticeStatus {
  draft,
  published,
  archived,
}


class NoticeModel {


  final String id;

  final String title;

  final String description;

  final NoticeCategory category;

  final NoticeTarget target;

  final NoticePriority priority;

  final NoticeStatus status;

  final DateTime publishDate;

  final DateTime expiryDate;

  final String createdBy;

  final bool isPinned;

  final String attachment;

  final DateTime createdAt;

  final DateTime updatedAt;



  NoticeModel({

    required this.id,

    required this.title,

    required this.description,

    required this.category,

    required this.target,

    required this.priority,

    required this.status,

    required this.publishDate,

    required this.expiryDate,

    required this.createdBy,

    required this.isPinned,

    required this.attachment,

    required this.createdAt,

    required this.updatedAt,

  });



  factory NoticeModel.fromMap(
      Map<String,dynamic> map
      ){

    return NoticeModel(

      id: map["id"] ?? "",

      title: map["title"] ?? "",

      description: map["description"] ?? "",

      category:
      NoticeCategory.values.firstWhere(
          (e)=>e.name==map["category"],
          orElse: ()=>NoticeCategory.general
      ),

      target:
      NoticeTarget.values.firstWhere(
          (e)=>e.name==map["target"],
          orElse: ()=>NoticeTarget.all
      ),


      priority:
      NoticePriority.values.firstWhere(
          (e)=>e.name==map["priority"],
          orElse: ()=>NoticePriority.normal
      ),


      status:
      NoticeStatus.values.firstWhere(
          (e)=>e.name==map["status"],
          orElse: ()=>NoticeStatus.draft
      ),


      publishDate:
      (map["publishDate"] as Timestamp)
          .toDate(),


      expiryDate:
      (map["expiryDate"] as Timestamp)
          .toDate(),


      createdBy:
      map["createdBy"] ?? "",


      isPinned:
      map["isPinned"] ?? false,


      attachment:
      map["attachment"] ?? "",


      createdAt:
      (map["createdAt"] as Timestamp)
          .toDate(),


      updatedAt:
      (map["updatedAt"] as Timestamp)
          .toDate(),

    );

  }



  Map<String,dynamic> toMap(){

    return {

      "title":title,

      "description":description,

      "category":category.name,

      "target":target.name,

      "priority":priority.name,

      "status":status.name,

      "publishDate":publishDate,

      "expiryDate":expiryDate,

      "createdBy":createdBy,

      "isPinned":isPinned,

      "attachment":attachment,

      "createdAt":createdAt,

      "updatedAt":updatedAt,

    };

  }


  NoticeModel copyWith({

  String? id,

  bool? isPinned,

  NoticeStatus? status,

  DateTime? updatedAt,

}) {

  return NoticeModel(

    id: id ?? this.id,

    title: title,

    description: description,

    category: category,

    target: target,

    priority: priority,

    status: status ?? this.status,

    publishDate: publishDate,

    expiryDate: expiryDate,

    createdBy: createdBy,

    isPinned: isPinned ?? this.isPinned,

    attachment: attachment,

    createdAt: createdAt,

    updatedAt: updatedAt ?? this.updatedAt,

  );

}
  
}