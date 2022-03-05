import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/screens/post/add_post.dart';
import 'package:flutter_social/screens/post/post_screen.dart';
import 'package:flutter_social/screens/profile/profile_screen.dart';
import 'package:flutter_social/screens/search/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const PostScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
