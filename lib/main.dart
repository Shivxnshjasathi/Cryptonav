import 'package:cryptonav/splash.dart';
import 'package:flutter/material.dart';
import 'package:cryptonav/functions.dart';

void main() async {
  currencies1();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );

  }}
