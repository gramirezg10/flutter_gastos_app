import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spends_app/src/api/spend_api.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  SpendAPI _spendAPI = SpendAPI();
  List<dynamic> _spends = [];
  List<dynamic> _spendHome = [];

  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final spends = await _spendAPI.getSpend();
    print('_loadData________________');
    print(spends);
    setState(() {
      _spends.addAll(spends);
      _spendHome.addAll(spends);
      _isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('--- home tab');
    return ListView(
      padding: EdgeInsets.all(15),
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFF81c784),
              ),
              alignment: Alignment.center,
              height: 150,
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text('Descripción: '),
                          // Text(_spendHome[0]['description']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Fecha:'),
                          // Text(_spendHome[0]['date']),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Valor:'),
                          // Text(_spendHome[0]['amount'].toString()),
                        ],
                      ),
                      // ListView.builder(
                      //   itemBuilder: (_, index){
                      //     final List<dynamic> _homeDetail = _spendHome[0]['homeDetail'];
                      //     final dynamic item = _homeDetail[index];
                      // },
                      // itemCount: _spendHome[0]['homeDetail'].length,)
                    ],
                  )),
            ),
            if (_isFetching)
              Positioned.fill(
                child: Container(
                  color: Colors.white70,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 15,
                    ),
                  ),
                ),
              )
          ],
        )
      ],
    );
  }

  // Future <dynamic> _getSpends() async {
  //   final resultAPI = await _spendAPI.getSpend();
  //   final dataConverted = jsonDecode(resultAPI);
  //   print('dataConverted ::::::::::::');
  //   print(dataConverted['spendsDB'][0]);
  //   return dataConverted['spendsDB'][0];
  // }
}
