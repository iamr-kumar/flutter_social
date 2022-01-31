import 'package:flutter/material.dart';
import 'package:flutter_social/responsive/mobile_screen_layout.dart';
import 'package:flutter_social/responsive/responsive_layout.dart';
import 'package:flutter_social/responsive/web_screen_layout.dart';
import 'package:flutter_social/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      title: 'Flutter Social',
      home: const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout()),
    );
  }
}
