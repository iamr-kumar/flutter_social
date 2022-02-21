import 'package:flutter/material.dart';

class PostDialog extends StatelessWidget {
  const PostDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        children: ['Delete']
            .map((e) => InkWell(
                onTap: () {},
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
