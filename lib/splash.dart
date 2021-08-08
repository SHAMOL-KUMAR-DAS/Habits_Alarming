import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      navigateAfterSeconds: Welcome(),
      seconds: 1,
      loadingText: Text("Connected with your habits",style: TextStyle(fontSize: 20,color: Colors.white),),
    );
  }
}