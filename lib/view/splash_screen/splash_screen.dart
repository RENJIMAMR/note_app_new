import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_new/utils/animation_constants.dart';
import 'package:note_app_new/view/home_screen/home_screen.dart';
import 'package:note_app_new/view/note_screen/note_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: Lottie.asset(AnimationConstants.SplashScreen_logo)));
  }
}
