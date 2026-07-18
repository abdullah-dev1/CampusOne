import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_edit_notice_page.dart';
import '../provider/notice_provider.dart';
import '../widgets/notice_card.dart';
import '../widgets/notice_filters.dart';
import '../widgets/notice_header.dart';
import '../widgets/notice_summary.dart';
import 'package:campusone/features/admin/notice_management/data/repository/firebase_notice_repository.dart';
import 'package:campusone/features/notices/data/models/notice_model.dart';

class NoticesPage extends StatelessWidget {

  final bool isAdmin;

  const NoticesPage({
    super.key,
    this.isAdmin = false,
  });


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      
create: (_) => NoticeProvider(
  FirebaseNoticeRepository(),
),
      child: Consumer<NoticeProvider>(
        builder: (context, provider, child) {

          return Scaffold(

            backgroundColor: const Color(0xffF8FAFC),


            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Notice Board",
              ),
            ),



            floatingActionButton: isAdmin
                ? FloatingActionButton.extended(

                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChangeNotifierProvider.value(
                            value: provider,
                            child:
                                const AddEditNoticePage(),
                          ),
                        ),
                      );

                    },

                    icon: const Icon(
                      Icons.add,
                    ),

                    label: const Text(
                      "Add Notice",
                    ),

                  )
                : null,



            body: SafeArea(

              child: ListView(

                padding:
                    const EdgeInsets.all(20),


                children: [


                  const NoticeHeader(),


                  const SizedBox(
                    height: 24,
                  ),


                  const NoticeSummary(),


                  const SizedBox(
                    height: 24,
                  ),


                  const NoticeFilters(),


                  const SizedBox(
                    height: 24,
                  ),



                  if(provider.filteredNotices.isEmpty)

                    const Padding(

                      padding:
                          EdgeInsets.all(40),

                      child: Center(

                        child: Text(
                          "No notices found.",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                      ),

                    ),




                  ...provider.filteredNotices.map(
                    (notice) {


                      // Students/Lecturers only see published notices

                      if(!isAdmin &&
                          notice.status !=
                              NoticeStatus.published){

                        return const SizedBox();

                      }



                      return NoticeCard(

                        notice: notice,


                        onDelete: isAdmin
                            ? () {

                                provider.deleteNotice(
                                  notice.id,
                                );

                              }
                            : null,



                        onPin: isAdmin
                            ? () {

                                provider.togglePin(
                                  notice.id,
                                );

                              }
                            : null,



                        onPublish: isAdmin
                            ? () {

                                provider.togglePublish(
                                  notice.id,
                                );

                              }
                            : null,



                        onEdit: isAdmin
                            ? () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ChangeNotifierProvider.value(
                                      value: provider,
                                      child:
                                          AddEditNoticePage(
                                        notice: notice,
                                      ),
                                    ),
                                  ),
                                );

                              }
                            : null,


                      );


                    },

                  ),


                ],

              ),

            ),

          );

        },

      ),

    );

  }

}