import 'package:flutter/material.dart';
import 'package:spends_app/src/pages/home_page.dart';
import 'package:spends_app/src/pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoute() {
  return <String, WidgetBuilder>{
    HomePage.pageName : (BuildContext context) => HomePage(), 
    LoginPage.pageName : (BuildContext context) => LoginPage(),
  };
}