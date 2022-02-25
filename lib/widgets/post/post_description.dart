import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:intl/intl.dart';

class PostDescription extends StatelessWidget {
  final int likes;
  final String username;
  final String description;
  final DateTime date;

  const PostDescription(
      {Key? key,
      required this.likes,
      required this.description,
      required this.username,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$likes likes', style: Theme.of(context).textTheme.bodyText2),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                    TextSpan(
                        text: username,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' $description',
                    )
                  ]))),
          InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'View all 200 comments',
                  style: const TextStyle(fontSize: 16, color: secondaryColor),
                )),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                DateFormat.yMMMd().format(date),
                style: const TextStyle(fontSize: 12, color: secondaryColor),
              )),
        ],
      ),
    );
  }
}
