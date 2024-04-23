import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'color_constants.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: ColorConstants.darkblue,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );
  }
}
