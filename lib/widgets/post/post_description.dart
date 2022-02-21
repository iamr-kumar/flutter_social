import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';

class PostDescription extends StatelessWidget {
  const PostDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('1,231 likes', style: Theme.of(context).textTheme.bodyText2),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                    TextSpan(
                        text: 'username',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' This is the description of my first post',
                    )
                  ]))),
          InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'View all 200 comments',
                  style: TextStyle(fontSize: 16, color: secondaryColor),
                )),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '22/12/2022',
                style: TextStyle(fontSize: 12, color: secondaryColor),
              )),
        ],
      ),
    );
  }
}
