import 'package:flutter/material.dart';
import 'package:scribblespace/mainmenu_screen.dart';
import 'SplashScreen.dart';
import 'registration_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenuScreen(),

    );
  }
}
