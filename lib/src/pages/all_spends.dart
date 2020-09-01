

import 'package:flutter/material.dart';
import 'package:spends_app/src/widgets/my_appbar.dart';
import 'package:spends_app/src/widgets/spend.dart';

class AllSpendsPage extends StatefulWidget {
  static final pageName = 'AllSpendsRoute';

  @override
  _AllSpendsPageState createState() => _AllSpendsPageState();
}

class _AllSpendsPageState extends State<AllSpendsPage> {
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
              onLeftClick: () => Navigator.pop(context)),
            Expanded(child: 

              Spend()
            
            
            
            
            )
          ],
        ),
      ),
    ));
  }
}
