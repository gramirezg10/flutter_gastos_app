import 'package:flutter/material.dart';
import 'package:spends_app/src/pages/home_page_tabs/add_spend_tab.dart';
import 'package:spends_app/src/pages/home_page_tabs/all_spends_tab.dart';
import 'package:spends_app/src/pages/home_page_tabs/home_tab.dart';
import 'package:spends_app/src/pages/home_page_tabs/settings_tab.dart';
import 'package:spends_app/src/widgets/bottom_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:spends_app/src/widgets/my_appbar.dart';
import 'package:spends_app/src/widgets/my_page_view.dart';

class HomePage extends StatefulWidget {
  static final pageName = 'HomePageRoute';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  
  final _menuItems = [
    BottomMenuItem(
        iconPath: 'assets/icons/home.svg',
        label: 'Home',
        content: HomeTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/add.svg',
        label: 'Add',
        content: AddSpendTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/list.svg',
        label: 'All',
        content: AllSpendsTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/settings3.svg',
        label: 'Ajustes',
        content: SettingsTab()),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        bottomNavigationBar: BottomMenu(
            currentPage: _currentPage,
            items: _menuItems,
            onChanged: (int newCurrentPage) {
              setState(() {
                _currentPage = newCurrentPage;
                
              });
            }),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              // se deja construido para un próximo uso
              MyAppBar(
                label: 'Gastos App',
                // rightIcon: 'assets/icons/settings2.svg',
                // onRightClick: () {
                //   // final route = MaterialPageRoute(builder: (context) => SettingsPage());
                //   // Navigator.push(context, route);
                //   Navigator.pushNamed(context, 'SettingsPageRoute');
                // },
                // leftIcon: 'assets/icons/settings2.svg',
                // onLeftClick: () => Navigator.pushNamed(context, 'SettingsPageRoute'),
              ),
              Divider(color: Colors.black26),
              Expanded(
                child: MyPageView(
                  children: _menuItems.map((item) => item.content).toList(),
                  currentPage: _currentPage,
                )
              )
            ],
          ),
        )));
  }
}

// CupertinoButton(
//           minSize: 0,
//             child: Text('Agregar ingreso'),
//             color: Colors.blue,
//             onPressed: () {
//               print('object');
//             })
