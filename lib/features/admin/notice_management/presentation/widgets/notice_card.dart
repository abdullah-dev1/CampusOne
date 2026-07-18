import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:campusone/features/notices/data/models/notice_model.dart';
import '../provider/notice_management_provider.dart';
import '../pages/add_edit_notice_page.dart';

class NoticeCard extends StatelessWidget {
  final NoticeModel notice;

  const NoticeCard({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        context.read<NoticeManagementProvider>();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                Expanded(
                  child: Text(
                    notice.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (notice.isPinned)
                  const Icon(
                    Icons.push_pin,
                    color: Colors.orange,
                  ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              notice.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [

                Chip(
                  label: Text(
                    notice.category.name.toUpperCase(),
                  ),
                ),

                Chip(
                  backgroundColor:
                      _priorityColor(
                    notice.priority,
                  ),
                  label: Text(
                    notice.priority.name.toUpperCase(),
                  ),
                ),

                Chip(
                  backgroundColor:
                      _statusColor(
                    notice.status,
                  ),
                  label: Text(
                    notice.status.name.toUpperCase(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              "Published : ${notice.publishDate}",
            ),

            Text(
              "Expiry : ${notice.expiryDate}",
            ),

            Text(
              "Created By : ${notice.createdBy}",
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit"),
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
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(
                      notice.isPinned
                          ? Icons.push_pin
                          : Icons.push_pin_outlined,
                    ),
                    label: Text(
                      notice.isPinned
                          ? "Unpin"
                          : "Pin",
                    ),
                    onPressed: () {
                      provider.togglePinned(
                        notice,
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  provider.changeStatus(
                    notice,
                    notice.status ==
                            NoticeStatus.published
                        ? NoticeStatus.archived
                        : NoticeStatus.published,
                  );
                },
                child: Text(
                  notice.status ==
                          NoticeStatus.published
                      ? "Archive Notice"
                      : "Publish Notice",
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () async {

                  final confirm =
                      await showDialog<bool>(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                      title:
                          const Text(
                        "Delete Notice",
                      ),
                      content:
                          const Text(
                        "Are you sure?",
                      ),
                      actions: [

                        TextButton(
                          onPressed: () =>
                              Navigator.pop(
                                  context,
                                  false),
                          child: const Text(
                              "Cancel"),
                        ),

                        FilledButton(
                          onPressed: () =>
                              Navigator.pop(
                                  context,
                                  true),
                          child: const Text(
                              "Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    provider.deleteNotice(
                      notice.id,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _priorityColor(
    NoticePriority priority,
  ) {
    switch (priority) {
      case NoticePriority.low:
        return Colors.green.shade100;

      case NoticePriority.normal:
        return Colors.blue.shade100;

      case NoticePriority.high:
        return Colors.orange.shade100;

      case NoticePriority.urgent:
        return Colors.red.shade100;
    }
  }

  Color _statusColor(
    NoticeStatus status,
  ) {
    switch (status) {
      case NoticeStatus.draft:
        return Colors.orange.shade100;

      case NoticeStatus.published:
        return Colors.green.shade100;

      case NoticeStatus.archived:
        return Colors.grey.shade300;
    }
  }
}