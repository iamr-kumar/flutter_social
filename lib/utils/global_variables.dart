import 'package:flutter/material.dart';
import 'package:flutter_social/screens/post/add_post.dart';
import 'package:flutter_social/screens/post/post_screen.dart';
import 'package:flutter_social/screens/search/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  SearchScreen(),
  PostScreen(),
  AddPostScreen(),
  Text('notifications'),
  Text('profile'),
];
