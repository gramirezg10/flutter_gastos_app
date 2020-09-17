import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spends_app/src/pages/home_page.dart';
import 'package:spends_app/src/pages/login_page.dart';
import 'package:spends_app/src/widgets/loader.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value){
      this._checkLoggin();
    });
  }

  _checkLoggin() async{ 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool wasLogin = prefs.getBool('wasLogin');
    if (wasLogin == null){
      Navigator.pushReplacementNamed(context, LoginPage.pageName);
    } else {
      Navigator.pushReplacementNamed(context, HomePage.pageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Loader()
    );
  }

}