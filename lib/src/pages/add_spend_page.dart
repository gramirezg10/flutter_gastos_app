import 'package:flutter/material.dart';
import 'package:spends_app/src/widgets/my_appbar.dart';
import 'package:spends_app/src/widgets/my_btn.dart';

class AddSpendPage extends StatefulWidget {
  static final pageName = 'AddSpendPageRoute';

  @override
  _AddSpendPageState createState() => _AddSpendPageState();
}

class _AddSpendPageState extends State<AddSpendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              MyAppBar(
                  leftIcon: 'assets/icons/left-arrow.svg',
                  // rightIcon: 'assets/icons/add.svg',
                  onLeftClick: () => Navigator.pop(context)
                  // onRightClick: (){
                  //   final route = MaterialPageRoute(builder: (context) => AddSpendPage());
                  //   Navigator.push(context, route);
                  // },
                  ),
              Expanded(child: Stack(
                
                children: [
                  Center(child: Text('Add Spend Page!')),
                  MyBtn(
                    icon: 'assets/icons/add.svg',
                    colorBackground: Colors.blue,
                    colorIcon: Colors.white,
                  )
                ],
              )
              ),
            ],
          ),
        ),
    ));
  }
}
