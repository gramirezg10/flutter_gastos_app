import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spends_app/src/api/google_signin_api.dart';
import 'package:spends_app/src/pages/login_page.dart';
import 'package:spends_app/src/util/dialogs.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authType = prefs.getString('wasLoginWith');
    switch (authType.toUpperCase()) {
      case 'GOOGLE':
        GoogleSignInApi.signOut();
        await prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, LoginPage.pageName, (route) => false);
        break;

      case 'APPLE':
        break;

      default:
        await prefs.clear();
        Navigator.pushNamedAndRemoveUntil(context, LoginPage.pageName, (route) => false);
        break;
    }
  }

  _confirmLogout() async {
    final isOk = await Dialogs.confirm(context, title: 'Acción requerida', body: '¿Está seguro que desea cerrar la sesión?');
    if (isOk) _logOut();
  }

  @override
  Widget build(BuildContext context) {
    print('--- Settings tab');
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CupertinoButton(
                padding: EdgeInsets.all(15),
                child: Container(
                    width: 180,
                    margin: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/exit.svg',
                          width: 30,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Cerrar sesión',
                          style:
                              TextStyle(letterSpacing: 1, color: Colors.black),
                        ),
                      ],
                    )),
                onPressed: _confirmLogout),
          ],
        ));
  }
}
