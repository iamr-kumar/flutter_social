import 'package:flutter/material.dart';

import 'post_dialog.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1645034647873-b8b84007c2f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDR8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('username', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        )),
        IconButton(
            onPressed: () {
              showDialog(context: context, builder: (ctx) => PostDialog());
            },
            icon: const Icon(Icons.more_vert))
      ],
    );
  }
}
