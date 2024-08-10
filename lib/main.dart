import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app_new/utils/app_sessions.dart';
import 'package:note_app_new/view/splash_screen/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(AppSessions.NOTEBOX);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
