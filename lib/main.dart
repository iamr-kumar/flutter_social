import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/providers/user.provider.dart';
import 'package:flutter_social/responsive/mobile_screen_layout.dart';
import 'package:flutter_social/responsive/responsive_layout.dart';
import 'package:flutter_social/responsive/web_screen_layout.dart';
import 'package:flutter_social/screens/auth/login_screen.dart';
import 'package:flutter_social/screens/auth/signup_screen.dart';
import 'package:flutter_social/utils/colors.dart';
import 'package:flutter_social/utils/firebase_web_keys.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: FIREBASE_API_KEY,
            messagingSenderId: FIREBASE_MESSEGING_SENDER_ID,
            appId: FIREBASE_APP_ID,
            projectId: FIREBASE_PROJECT_ID,
            storageBucket: FIREBASE_STORAGE_BUCKET));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          title: 'Flutter Social',
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return const LoginScreen();
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ));
              }
              return const LoginScreen();
            },
          )),
    );
  }
}
