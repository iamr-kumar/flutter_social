import 'package:flutter/material.dart';
import 'package:flutter_social/models/User.model.dart';
import 'package:flutter_social/providers/user.provider.dart';
import 'package:provider/provider.dart';

import 'post_dialog.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String profileImage;
  final String postId;
  final String uid;

  const PostHeader(
      {Key? key,
      required this.username,
      required this.profileImage,
      required this.uid,
      required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            profileImage,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        )),
        IconButton(
            onPressed: () {
              if (user.uid == uid) {
                showDialog(
                    context: context,
                    builder: (ctx) => PostDialog(postId: postId));
              }
            },
            icon: const Icon(Icons.more_vert))
      ],
    );
  }
}
