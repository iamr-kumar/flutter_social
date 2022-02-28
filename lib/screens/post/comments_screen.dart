import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/User.model.dart';
import 'package:flutter_social/providers/user.provider.dart';
import 'package:flutter_social/resources/firestore_methods.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/widgets/layout/user_avatar.dart';
import 'package:flutter_social/widgets/post/comment_card.dart';
import 'package:flutter_social/widgets/post/comments_list.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: CommentsList(postId: widget.snap['postId'].toString()),
      bottomNavigationBar: SafeArea(
          child: Container(
        height: kToolbarHeight,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Row(children: [
          UserAvatar(imageUrl: user.photoUrl),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8),
              child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      border: InputBorder.none)),
            ),
          ),
          InkWell(
              onTap: () async {
                await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    _commentController.text,
                    user.uid,
                    user.username,
                    user.photoUrl);
                setState(() {
                  _commentController.text = '';
                });
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text('Post',
                      style: TextStyle(color: Colors.blueAccent))))
        ]),
      )),
    );
  }
}
