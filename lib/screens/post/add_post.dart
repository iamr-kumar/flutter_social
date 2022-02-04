import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(icon: Icon(Icons.upload), onPressed: () {}),
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Post to'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Post',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1643260669988-31da7ec61233?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDM2fGJvOGpRS1RhRTBZfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
              ),
              SizedBox(
                child: const TextField(
                  decoration: InputDecoration(
                      hintText: 'Write a caption...', border: InputBorder.none),
                  maxLines: 8,
                ),
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(
                  height: 45,
                  width: 45,
                  child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1642866737821-532bc817c068?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDQ1fGJvOGpRS1RhRTBZfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.center)),
                      ))),
              const Divider()
            ],
          )
        ],
      ),
    );
  }
}
