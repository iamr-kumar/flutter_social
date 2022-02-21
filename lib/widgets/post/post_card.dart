import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/widgets/post/post_description.dart';
import 'package:flutter_social/widgets/post/post_header.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // HEADER SECTION
          Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: PostHeader()),

          // IMAGE SECTION
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1644322749926-66ac55e2913e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
                fit: BoxFit.cover,
              )),

          // BOTTOM SECTION
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite, color: Colors.red)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.comment_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_outline))))
            ],
          ),

          // DESCRIPTION
          PostDescription()
        ],
      ),
    );
  }
}
