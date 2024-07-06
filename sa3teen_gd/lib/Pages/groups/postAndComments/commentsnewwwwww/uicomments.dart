// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gp_screen/Pages/apis/CommentsProvider.dart';
import 'package:gp_screen/Pages/groups/Widgets/tabBar.dart';
import 'package:gp_screen/Pages/groups/postAndComments/commentsnewwwwww/Commentmodel.dart';
import 'package:gp_screen/widgets/constantsAcrossTheApp/constants.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final int groupId;
  final int postId;

  const CommentsScreen({required this.groupId, required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CommentsProvider>(context, listen: false)
        .fetchComments(widget.groupId, widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabbar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CommentsProvider>(
              builder: (context, commentsProvider, _) {
                if (commentsProvider.comments.isEmpty) {
                  return const Center(child: Text('No comments yet.'));
                }
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: commentsProvider.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentsProvider.comments[index];
                          return CommentItem(
                            groupId: widget.groupId,
                            postId: widget.postId,
                            comment: comment,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: kprimaryColourcream,
                  ),
                  onPressed: () async {
                    final value = _commentController.text;
                    if (value.isNotEmpty) {
                      await Provider.of<CommentsProvider>(context,
                              listen: false)
                          .postComment(widget.groupId, widget.postId, value);
                      await Provider.of<CommentsProvider>(context,
                              listen: false)
                          .fetchComments(widget.groupId, widget.postId);
                      _commentController.clear();
                    }
                  },
                ),
                labelText: 'Add a comment',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItem extends StatefulWidget {
  final int groupId;
  final int postId;
  final Comment comment;

  const CommentItem(
      {required this.groupId, required this.postId, required this.comment});

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool _showReplies = false;
  final TextEditingController _replyController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            children: [
              widget.comment.user.image != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.comment.user.image!),
                    )
                  : CircleAvatar(
                      backgroundColor: kprimaryColourcream,
                      child: Text(widget.comment.user.username[0]),
                    ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  color: kprimaryColourWhite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        Text('     ${widget.comment.user.username}'),
                        Row(
                          children: [
                            Text('     ${widget.comment.description}'),
                            const Spacer(
                              flex: 1,
                            ),
                            IconButton(
                              icon: Icon(
                                _showReplies
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: kprimaryColourcream,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showReplies = !_showReplies;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: kprimaryColourcream,
                              ),
                              onPressed: () async {
                                await Provider.of<CommentsProvider>(context,
                                        listen: false)
                                    .deleteComment(context, widget.groupId,
                                        widget.postId, widget.comment.id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: kprimaryColourcream,
                              ),
                              onPressed: () {
                                _showEditDialog(context, widget.comment);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_showReplies) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.comment.replies.length,
              itemBuilder: (context, replyIndex) {
                final reply = widget.comment.replies[replyIndex];
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    children: [
                      reply.user.image != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(reply.user.image!),
                            )
                          : CircleAvatar(
                              backgroundColor: kprimaryColourcream,
                              child: Text(reply.user.username[0]),
                            ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('  ${reply.user.username}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("  ${reply.description}"),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: kprimaryColourcream,
                                      ),
                                      onPressed: () async {
                                        await Provider.of<CommentsProvider>(
                                                context,
                                                listen: false)
                                            .deleteReply(
                                                context,
                                                widget.groupId,
                                                widget.postId,
                                                widget.comment.id,
                                                reply.id);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: kprimaryColourcream,
                                      ),
                                      onPressed: () {
                                        _showEditReplyDialog(
                                            context, widget.comment, reply);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 8, bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: kprimaryColourcream,
                    ),
                    onPressed: () async {
                      final value = _replyController.text;
                      if (value.isNotEmpty) {
                        await Provider.of<CommentsProvider>(context,
                                listen: false)
                            .postReply(widget.groupId, widget.postId,
                                widget.comment.id, value);
                        _replyController.clear();
                      }
                    },
                  ),
                  labelText: 'Add a reply',
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showEditDialog(BuildContext context, Comment comment) {
    final TextEditingController descriptionController =
        TextEditingController(text: comment.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Comment'),
        content: TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final newDescription = descriptionController.text;
              if (newDescription.isNotEmpty) {
                await Provider.of<CommentsProvider>(context, listen: false)
                    .editComment(ctx, widget.groupId, widget.postId, comment.id,
                        newDescription);
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditReplyDialog(
      BuildContext context, Comment comment, Reply reply) {
    final TextEditingController descriptionController =
        TextEditingController(text: reply.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Reply'),
        content: TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final newDescription = descriptionController.text;
              if (newDescription.isNotEmpty) {
                print('hi');
                await Provider.of<CommentsProvider>(context, listen: false)
                    .editReply(ctx, widget.groupId, widget.postId, comment.id,
                        reply.id, newDescription);
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
