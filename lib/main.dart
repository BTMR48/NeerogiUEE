import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:neerogi/screens/login.dart';

import 'package:neerogi/screens/Articles/ArticleIntroScreen.dart';
import 'package:neerogi/screens/ScreenTest/screenTest_screen.dart';
import 'package:neerogi/screens/Articles/Admin/view_articles.dart';
import 'package:neerogi/core/app_style.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email And  Password Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,

      home: LoginScreen(),

    );
  }
}
