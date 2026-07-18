import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';

import '../provider/notice_management_provider.dart';

import 'add_edit_notice_page.dart';

class NoticeDetailsPage extends StatelessWidget {
  final NoticeModel notice;

  const NoticeDetailsPage({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.read<NoticeManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notice Details",
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.edit),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ChangeNotifierProvider.value(
                    value: provider,

                    child: AddEditNoticePage(
                      notice: notice,
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [

          Card(
            elevation: 1,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    notice.title,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: [

                      _StatusChip(
                        notice.status,
                      ),

                      _PriorityChip(
                        notice.priority,
                      ),

                      _CategoryChip(
                        notice.category,
                      ),

                      if (notice.isPinned)

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration:
                              BoxDecoration(
                            color: Colors
                                .amber
                                .shade100,

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        20),
                          ),

                          child: Text(
                            "Pinned",

                            style:
                                TextStyle(
                              color: Colors
                                  .amber
                                  .shade900,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),

                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Description",

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    notice.description,

                    style: TextStyle(
                      fontSize: 16,
                      color:
                          Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),
                                    Row(
                    children: [

                      Expanded(
                        child: _InfoTile(
                          title: "Created By",
                          value: notice.createdBy,
                        ),
                      ),

                      Expanded(
                        child: _InfoTile(
                          title: "Target",
                          value: notice.target.name
                              .toUpperCase(),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      Expanded(
                        child: _InfoTile(
                          title: "Publish Date",
                          value: notice.publishDate,
                        ),
                      ),

                      Expanded(
                        child: _InfoTile(
                          title: "Expiry Date",
                          value: notice.expiryDate,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,

                    child: FilledButton.icon(
                      icon: Icon(
                        notice.status ==
                                NoticeStatus
                                    .published
                            ? Icons.archive
                            : Icons.public,
                      ),

                      label: Text(
                        notice.status ==
                                NoticeStatus
                                    .published
                            ? "Archive Notice"
                            : "Publish Notice",
                      ),

                      onPressed: () {

                        provider.changeStatus(
                          notice.id,

                          notice.status ==
                                  NoticeStatus
                                      .published
                              ? NoticeStatus
                                  .archived
                              : NoticeStatus
                                  .published,
                        );

                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,

                    child: OutlinedButton.icon(
                      icon: Icon(
                        notice.isPinned
                            ? Icons.push_pin
                            : Icons
                                .push_pin_outlined,
                      ),

                      label: Text(
                        notice.isPinned
                            ? "Unpin Notice"
                            : "Pin Notice",
                      ),

                      onPressed: () {

                        provider.togglePinned(
                          notice.id,
                        );

                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,

                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      label: const Text(
                        "Delete Notice",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),

                      onPressed: () async {

                        final delete =
                            await showDialog<bool>(
                          context: context,

                          builder: (_) =>
                              AlertDialog(
                            title: const Text(
                              "Delete Notice",
                            ),

                            content: const Text(
                              "Are you sure you want to delete this notice?",
                            ),

                            actions: [

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    false,
                                  );
                                },

                                child:
                                    const Text(
                                  "Cancel",
                                ),
                              ),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    true,
                                  );
                                },

                                child:
                                    const Text(
                                  "Delete",
                                ),
                              ),

                            ],
                          ),
                        );

                        if (delete == true) {

                          provider.deleteNotice(
                            notice.id,
                          );

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {

  final String title;

  final String value;

  const _InfoTile({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Text(
          title,

          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,

          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    );
  }
}

class _StatusChip extends StatelessWidget {

  final NoticeStatus status;

  const _StatusChip(this.status);

  @override
  Widget build(BuildContext context) {

    Color color;
    String text;

    switch (status) {
      case NoticeStatus.published:
        color = Colors.green;
        text = "Published";
        break;

      case NoticeStatus.draft:
        color = Colors.orange;
        text = "Draft";
        break;

      case NoticeStatus.archived:
        color = Colors.grey;
        text = "Archived";
        break;
    }

    return Chip(
      backgroundColor: color.withOpacity(.15),

      label: Text(
        text,

        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {

  final NoticePriority priority;

  const _PriorityChip(this.priority);

  @override
  Widget build(BuildContext context) {

    Color color;

    switch (priority) {
      case NoticePriority.low:
        color = Colors.green;
        break;

      case NoticePriority.normal:
        color = Colors.blue;
        break;

      case NoticePriority.high:
        color = Colors.orange;
        break;

      case NoticePriority.urgent:
        color = Colors.red;
        break;
    }

    return Chip(
      backgroundColor: color.withOpacity(.15),

      label: Text(
        priority.name.toUpperCase(),

        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {

  final NoticeCategory category;

  const _CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {

    return Chip(
      backgroundColor:
          Colors.indigo.withOpacity(.12),

      label: Text(
        category.name.toUpperCase(),

        style: const TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}