import 'package:flutter/material.dart';
import 'package:flutter_social/widgets/layout/user_avatar.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            UserAvatar(imageUrl: widget.snap['profilePic']),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: widget.snap['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' ${widget.snap['text']}'),
                    ])),
                    Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          DateFormat.yMMMd()
                              .format((widget.snap['datePosted'].toDate())),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ))
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.favorite_outline,
                  size: 20,
                ))
          ],
        ));
  }
}
