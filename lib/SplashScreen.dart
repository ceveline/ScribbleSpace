import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scribblespace/color_constants.dart';
import 'package:scribblespace/home_screen.dart';
import 'package:scribblespace/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    //to navigate to the login screen after 2 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginScreen()));
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); //bring back the bottom menu
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //fix the location of the background
        color: ColorConstants.darkblue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.png')
          ],
        ),
      ),
    );
  }
}

/*
Gradient Background
Container(
        width: double.infinity, //fix the location of the background
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.deepPurpleAccent, Colors.purple],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon.png')
          ],
        ),
      ),
 */

