import 'package:flutter/material.dart';
//import 'package:homestay_raya_ass2/splashscreen.dart';
import 'SplashScreen.dart';
//import 'package:homestay_raya_ass2/views/';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homestay Raya',
      theme: ThemeData(
        // ignore: prefer_const_constructorsr
        primarySwatch: Colors.brown,
      ),
      home: const SplashScreen(),
    );
  }
}
