import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/utils.dart';
import 'package:flutter_social/widgets/profile/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool _isFollowing = false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      // get posts
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      userData = userSnap.data()!;
      postLength = postSnap.docs.length;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      _isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      showSnackbar(context, err.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData['username']),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              userData['photoUrl'],
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postLength, 'Posts'),
                                    buildStatColumn(followers, 'Followers'),
                                    buildStatColumn(following, 'Following'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(userData['username'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(top: 1),
                              child: Text(
                                userData['bio'],
                              )),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  backgroundColor: mobileBackgroundColor,
                                  borderColor: Colors.grey,
                                  text: 'Edit Profile',
                                  textColor: primaryColor,
                                  function: () {},
                                )
                              : _isFollowing
                                  ? FollowButton(
                                      backgroundColor: Colors.white,
                                      borderColor: Colors.grey,
                                      text: 'Unfollow',
                                      textColor: Colors.black,
                                      function: () {},
                                    )
                                  : FollowButton(
                                      backgroundColor: Colors.blue,
                                      borderColor: Colors.blue,
                                      text: 'Follow',
                                      textColor: Colors.white,
                                      function: () {},
                                    )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ))
        : const Center(child: CircularProgressIndicator());
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)),
        )
      ],
    );
  }
}
