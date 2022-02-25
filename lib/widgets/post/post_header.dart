import 'package:flutter/material.dart';

import 'post_dialog.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String profileImage;

  const PostHeader(
      {Key? key, required this.username, required this.profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text(username, style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        )),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (ctx) => const PostDialog());
            },
            icon: const Icon(Icons.more_vert))
      ],
    );
  }
}
