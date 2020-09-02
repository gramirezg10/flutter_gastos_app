import 'package:flutter/material.dart';
import 'package:spends_app/src/pages/add_spend_page.dart';
import 'package:spends_app/src/pages/all_spends.dart';
import 'package:spends_app/src/pages/home_page.dart';
import 'package:spends_app/src/pages/login_page.dart';
import 'package:spends_app/src/pages/settings_page.dart';

Map<String, WidgetBuilder> getAppRoute() {
  return <String, WidgetBuilder>{
    HomePage.pageName : (BuildContext context) => HomePage(), 
    AddSpendPage.pageName : (BuildContext context) => AddSpendPage(), 
    SettingsPage.pageName : (BuildContext context) => SettingsPage(),
    AllSpendsPage.pageName : (BuildContext context) => AllSpendsPage(),
    LoginPage.pageName : (BuildContext context) => LoginPage(),
  };
}