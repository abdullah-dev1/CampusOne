import 'package:flutter/material.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';


class NoticeCard extends StatelessWidget {

  final NoticeModel notice;

  final VoidCallback? onDelete;

  final VoidCallback? onPin;

  final VoidCallback? onPublish;

  final VoidCallback? onEdit;



  const NoticeCard({

    super.key,

    required this.notice,

    this.onDelete,

    this.onPin,

    this.onPublish,

    this.onEdit,

  });



  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),


      child: ListTile(


        leading: Icon(

          notice.isPinned
              ? Icons.push_pin
              : Icons.notifications,

        ),



        title: Text(

          notice.title,

          maxLines: 1,

          overflow:
              TextOverflow.ellipsis,

        ),



        subtitle: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [


            Text(

              notice.description,

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,

            ),



            const SizedBox(
              height: 5,
            ),



            Text(

              "${notice.status.name.toUpperCase()} • ${notice.priority.name.toUpperCase()}",

              style: const TextStyle(
                fontSize: 12,
              ),

            ),

          ],

        ),




        trailing: PopupMenuButton<String>(


          onSelected: (value) {


            switch(value) {


              case "edit":

                onEdit?.call();

                break;



              case "delete":

                onDelete?.call();

                break;



              case "pin":

                onPin?.call();

                break;



              case "publish":

                onPublish?.call();

                break;


            }


          },



          itemBuilder: (context) => [


            if(onEdit != null)

              const PopupMenuItem(

                value: "edit",

                child: Text(
                  "Edit",
                ),

              ),



            if(onPin != null)

              PopupMenuItem(

                value: "pin",

                child: Text(

                  notice.isPinned
                      ? "Unpin"
                      : "Pin",

                ),

              ),



            if(onPublish != null)

              const PopupMenuItem(

                value: "publish",

                child: Text(
                  "Change Status",
                ),

              ),



            if(onDelete != null)

              const PopupMenuItem(

                value: "delete",

                child: Text(
                  "Delete",
                ),

              ),


          ],


        ),


      ),


    );

  }

}