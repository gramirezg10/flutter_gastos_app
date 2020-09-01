import 'package:flutter/material.dart';
import 'package:spends_app/src/config/routes.dart';
import 'package:spends_app/src/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashPage(),
      routes: getAppRoute(),
    );
  }
}

