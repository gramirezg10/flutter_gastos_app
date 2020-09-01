import 'package:flutter/material.dart';
import 'package:spends_app/src/pages/add_spend_page.dart';
import 'package:spends_app/src/pages/all_spends.dart';
import 'package:spends_app/src/widgets/bottom_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:spends_app/src/widgets/my_appbar.dart';

class HomePage extends StatefulWidget {
  static final pageName = 'HomePageRoute';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final pageName = 'HomePageRoute';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.blue[400],
        bottomNavigationBar: BottomMenu(items: [
          BottomMenuItem(iconPath: 'assets/icons/home.svg', label: 'Home', nav: pageName),
          BottomMenuItem(iconPath: 'assets/icons/add.svg', label: 'Add', nav: AddSpendPage.pageName),
          BottomMenuItem(iconPath: 'assets/icons/list.svg', label: 'All', nav: AllSpendsPage.pageName),
        ]),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                MyAppBar(
                  rightIcon: 'assets/icons/settings2.svg',
                  onRightClick: (){
                    // final route = MaterialPageRoute(builder: (context) => SettingsPage());
                    // Navigator.push(context, route);
                    Navigator.pushNamed(context, 'SettingsPageRoute');
                  },
                ),
                Expanded(
                  child: 
                    Center(child: Text('Contenido de la pag de gastos')))
              ],
            ),
          )
        )
      );
  }
}


// CupertinoButton(
//           minSize: 0,
//             child: Text('Agregar ingreso'),
//             color: Colors.blue,
//             onPressed: () {
//               print('object');
//             })