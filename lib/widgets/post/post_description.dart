import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/screens/post/comments_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:intl/intl.dart';

class PostDescription extends StatefulWidget {
  final int likes;
  final String username;
  final String description;
  final DateTime date;
  final String postId;
  final snap;

  const PostDescription(
      {Key? key,
      required this.likes,
      required this.description,
      required this.username,
      required this.postId,
      required this.snap,
      required this.date})
      : super(key: key);

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
  int _commentLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .get();
      setState(() {
        _commentLength = snap.docs.length;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.likes} likes',
              style: Theme.of(context).textTheme.bodyText2),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                    TextSpan(
                        text: widget.username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' ${widget.description}',
                    )
                  ]))),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentsScreen(snap: widget.snap)));
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'View all $_commentLength comments',
                  style: const TextStyle(fontSize: 16, color: secondaryColor),
                )),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                DateFormat.yMMMd().format(widget.date),
                style: const TextStyle(fontSize: 12, color: secondaryColor),
              )),
        ],
      ),
    );
  }
}
