import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spends_app/src/config/routes.dart';
import 'package:spends_app/src/pages/splash_page.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if (focus.hasPrimaryFocus) focus.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashPage(),
        routes: getAppRoute(),
      ),
    );
  }
}
