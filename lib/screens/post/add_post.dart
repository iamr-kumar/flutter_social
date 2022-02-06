import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_social/models/User.model.dart';
import 'package:flutter_social/providers/user.provider.dart';
import 'package:flutter_social/resources/auth_methods.dart';

import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  TextEditingController descController = TextEditingController();

  _showDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
                icon: const Icon(Icons.upload),
                onPressed: () => _showDialogBox(context)),
          )
        : Scaffold(
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
                    CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                    SizedBox(
                      child: TextField(
                        controller: descController,
                        decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none),
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
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: MemoryImage(_file!),
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
