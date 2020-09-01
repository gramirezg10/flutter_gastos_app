import 'package:flutter/material.dart';
import 'package:spends_app/src/widgets/my_appbar.dart';

class SettingsPage extends StatefulWidget {

  static final pageName = 'SettingsPageRoute';

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyAppBar(
              leftIcon: 'assets/icons/left-arrow.svg',
              // rightIcon: 'assets/icons/add.svg',
              onLeftClick: () => Navigator.pop(context)
              // onRightClick: (){
              //   final route = MaterialPageRoute(builder: (context) => SettingsPage());
              //   Navigator.push(context, route);
              // },
            ),
            Center(child: Text('Settings Page!'))
          ],
        ),
      ),
    ));
  }
}
