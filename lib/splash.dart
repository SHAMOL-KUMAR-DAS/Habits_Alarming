import 'package:flutter/material.dart';
import 'package:jouleslab/home.dart';
import 'package:jouleslab/welcome.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.lightGreenAccent,
      // image: Image(
      //   image: AssetImage("assets/images/splash_image.png"),
      //   // height: 1200,
      //   // width: 1200,
      //   fit: BoxFit.fill,
      // ),
      navigateAfterSeconds: Welcome(),
      seconds: 3,
      loadingText: Text("Connected with your habits",style: TextStyle(fontSize: 20),),
    );
  }
}