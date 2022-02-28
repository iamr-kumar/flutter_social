import 'package:flutter/material.dart';
import 'package:flutter_social/resources/firestore_methods.dart';

class PostDialog extends StatelessWidget {
  final String postId;
  const PostDialog({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        children: ['Delete']
            .map((e) => InkWell(
                onTap: () async {
                  await FirestoreMethods().deletePost(postId);
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(e),
                )))
            .toList(),
      ),
    );
  }
}
