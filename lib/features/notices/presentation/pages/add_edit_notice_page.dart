import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';
import '../../../admin/notice_management/presentation/provider/notice_management_provider.dart';


class AddEditNoticePage extends StatefulWidget {

  final NoticeModel? notice;

  const AddEditNoticePage({
    super.key,
    this.notice,
  });


  @override
  State<AddEditNoticePage> createState() =>
      _AddEditNoticePageState();
}



class _AddEditNoticePageState extends State<AddEditNoticePage> {


  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();


  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController createdByController;


  late NoticeCategory category;
  late NoticeTarget target;
  late NoticePriority priority;


  bool isPinned = false;

  NoticeStatus status = NoticeStatus.published;


  late DateTime publishDate;
  late DateTime expiryDate;



  @override
  void initState() {

    super.initState();


    final notice = widget.notice;


    titleController = TextEditingController(
      text: notice?.title ?? "",
    );


    descriptionController = TextEditingController(
      text: notice?.description ?? "",
    );


    createdByController = TextEditingController(
      text: notice?.createdBy ?? "",
    );



    category =
        notice?.category ??
        NoticeCategory.general;


    target =
        notice?.target ??
        NoticeTarget.all;


    priority =
        notice?.priority ??
        NoticePriority.normal;



    isPinned =
        notice?.isPinned ?? false;



    status =
        notice?.status ??
        NoticeStatus.published;



    publishDate =
    notice?.publishDate ??
    DateTime.now();

expiryDate =
    notice?.expiryDate ??
    DateTime.now().add(
      const Duration(days: 30),
    );

}






  @override
  void dispose() {

    titleController.dispose();
    descriptionController.dispose();
    createdByController.dispose();

    super.dispose();

  }





  Future<void> _pickExpiryDate() async {


    final picked =
        await showDatePicker(

      context: context,

      initialDate: expiryDate,

      firstDate: DateTime.now(),

      lastDate: DateTime(2035),

    );



    if(picked != null){

      setState((){

        expiryDate = picked;

      });

    }

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        centerTitle:true,

        title: Text(
          widget.notice == null
              ? "Add Notice"
              : "Edit Notice",
        ),

      ),



      body: Form(

        key:_formKey,


        child: ListView(

          padding:
          const EdgeInsets.all(20),



          children:[


            TextFormField(

              controller:titleController,

              decoration:
              const InputDecoration(

                labelText:"Notice Title",

                border:
                OutlineInputBorder(),

              ),


              validator:(value){

                if(value == null ||
                    value.trim().isEmpty){

                  return "Enter notice title";

                }

                return null;

              },

            ),



            const SizedBox(height:18),



            TextFormField(

              controller:descriptionController,

              maxLines:5,


              decoration:
              const InputDecoration(

                labelText:"Description",

                border:
                OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:18),



            TextFormField(

              controller:createdByController,


              decoration:
              const InputDecoration(

                labelText:"Created By",

                border:
                OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:18),



            DropdownButtonFormField<NoticeCategory>(

              value:category,


              decoration:
              const InputDecoration(

                labelText:"Category",

                border:
                OutlineInputBorder(),

              ),


              items:
              NoticeCategory.values.map(

                    (e)=>DropdownMenuItem(

                  value:e,

                  child:
                  Text(e.name.toUpperCase()),

                ),

              ).toList(),


              onChanged:(value){

                if(value != null){

                  setState((){

                    category=value;

                  });

                }

              },

            ),



            const SizedBox(height:18),



            DropdownButtonFormField<NoticeTarget>(

              value:target,


              decoration:
              const InputDecoration(

                labelText:"Target",

                border:
                OutlineInputBorder(),

              ),



              items:
              NoticeTarget.values.map(

                    (e)=>DropdownMenuItem(

                  value:e,

                  child:
                  Text(e.name.toUpperCase()),

                ),

              ).toList(),



              onChanged:(value){

                if(value != null){

                  setState((){

                    target=value;

                  });

                }

              },

            ),



            const SizedBox(height:18),



            DropdownButtonFormField<NoticePriority>(

              value:priority,


              decoration:
              const InputDecoration(

                labelText:"Priority",

                border:
                OutlineInputBorder(),

              ),



              items:
              NoticePriority.values.map(

                    (e)=>DropdownMenuItem(

                  value:e,

                  child:
                  Text(e.name.toUpperCase()),

                ),

              ).toList(),



              onChanged:(value){

                if(value != null){

                  setState((){

                    priority=value;

                  });

                }

              },

            ),




            SwitchListTile(

              title:
              const Text("Pinned Notice"),


              value:isPinned,


              onChanged:(value){

                setState((){

                  isPinned=value;

                });

              },

            ),




            SwitchListTile(

              title:
              const Text("Publish Notice"),


              value:
              status == NoticeStatus.published,


              onChanged:(value){

                setState((){

                  status =
                  value
                      ? NoticeStatus.published
                      : NoticeStatus.draft;

                });

              },

            ),




            ListTile(

              title:
              const Text("Expiry Date"),


              subtitle:
              Text(
                DateFormat(
                    "dd MMM yyyy"
                ).format(expiryDate),
              ),


              trailing:
              const Icon(
                  Icons.calendar_month
              ),


              onTap:_pickExpiryDate,

            ),




            const SizedBox(height:30),




            ElevatedButton.icon(

              icon:
              Icon(
                widget.notice == null
                    ? Icons.add
                    : Icons.save,
              ),



              label:
              Text(
                widget.notice == null
                    ? "Add Notice"
                    : "Update Notice",
              ),



              onPressed:() async {


                if(!_formKey.currentState!.validate()){

                  return;

                }
            


                final provider =
                context.read<NoticeManagementProvider>();



                final now =
                DateTime.now();



                final notice =
                NoticeModel(


                  id:
                  widget.notice?.id ?? "",


                  title:
                  titleController.text.trim(),


                  description:
                  descriptionController.text.trim(),


                  category:category,


                  target:target,


                  priority:priority,


                  status:status,


                  publishDate:publishDate,


                  expiryDate:expiryDate,


                  createdBy:
                  createdByController.text.trim(),


                  isPinned:isPinned,


                  attachment:"",


                  createdAt:
                  widget.notice?.createdAt ?? now,


                  updatedAt:now,

                );



                if(widget.notice == null){

                  await provider.addNotice(notice);

                }
                else{

                  await provider.updateNotice(notice);

                }



                if(mounted){

                  Navigator.pop(context);

                }

              },

            )


          ],

        ),

      ),

    );

  }

}