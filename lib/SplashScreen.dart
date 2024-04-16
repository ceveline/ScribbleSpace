import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scribblespace/home_screen.dart';

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

    //to navigate to the home screen after 2 seconds
    /*
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
    });

     */
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
        color: Color(0xff21203D),
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

