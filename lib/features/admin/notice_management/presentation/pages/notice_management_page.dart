import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/service_locator.dart';

import '../../domain/repository/notice_repository.dart';

import '../provider/notice_management_provider.dart';

import '../widgets/notice_header.dart';
import '../widgets/notice_statistics.dart';
import '../widgets/notice_filters.dart';
import '../widgets/notice_card.dart';

import 'add_edit_notice_page.dart';

class NoticeManagementPage extends StatelessWidget {
  const NoticeManagementPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoticeManagementProvider(
        locator<NoticeRepository>(),
      )..loadNotices(),

      child: const _NoticeManagementView(),
    );
  }
}

class _NoticeManagementView extends StatelessWidget {
  const _NoticeManagementView();

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeManagementProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        return Scaffold(
          backgroundColor:
              const Color(0xffF8FAFC),

          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const Text(
              "Notice Management",
            ),
          ),

          body: RefreshIndicator(
            onRefresh: () async {
              await provider.loadNotices();
            },

            child: ListView(
              padding:
                  const EdgeInsets.all(20),

              children: [

                const NoticeHeader(),

                const SizedBox(height: 20),

                const NoticeStatistics(),

                const SizedBox(height: 20),

                const NoticeFilters(),

                const SizedBox(height: 20),

                if (provider.isLoading)

                  const Padding(
                    padding:
                        EdgeInsets.all(60),
                    child: Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                  )

                else if (provider.filteredNotices.isEmpty)

                  Container(
                    padding:
                        const EdgeInsets.all(
                            40),

                    child: Column(
                      children: [

                        Icon(
                          Icons
                              .campaign_outlined,
                          size: 90,
                          color: Colors
                              .grey,
                        ),

                        const SizedBox(
                            height: 20),

                        const Text(
                          "No Notices Found",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height: 12),

                        Text(
                          "Create your first notice using the button below.",
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            color: Colors
                                .grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )

                else

                  ...provider.filteredNotices
                      .map(
                    (notice) =>
                        NoticeCard(
                      notice: notice,
                    ),
                  ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          floatingActionButton:
              FloatingActionButton.extended(
            icon: const Icon(
              Icons.add,
            ),

            label: const Text(
              "Add Notice",
            ),

            onPressed: () async {
              await Navigator.push(
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

              if (context.mounted) {
                provider.loadNotices();
              }
            },
          ),
        );
      },
    );
  }
}