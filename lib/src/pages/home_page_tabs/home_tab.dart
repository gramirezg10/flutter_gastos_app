import 'package:flutter/material.dart';
import 'package:spends_app/src/api/spend_api.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  SpendAPI _spendAPI = SpendAPI();
  @override
  Widget build(BuildContext context) {
    // final resultAPI = await _spendAPI.spend(resultAuth);
    // print(resultAuth);
    print('--- home tab');
    return Center(
      child: Text('Home tab content!!!!'),
    );
  }
}
