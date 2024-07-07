// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class CommentActions extends StatelessWidget {
  final int groupId;
  final int postId;
  final int commentId;
  final int? replyId;
  final Function(BuildContext, int, int, int) deleteCallback;
  final Function(BuildContext, int, int, int, int?) editCallback;

  CommentActions({
    required this.groupId,
    required this.postId,
    required this.commentId,
    this.replyId,
    required this.deleteCallback,
    required this.editCallback,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert, color: kprimaryColourcream),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.delete, color: kprimaryColourcream),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.edit, color: kprimaryColourcream),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        if (value == 1) {
          deleteCallback(context, groupId, postId, commentId);
        } else if (value == 2) {
          editCallback(context, groupId, postId, commentId, replyId);
        }
      },
    );
  }
}
