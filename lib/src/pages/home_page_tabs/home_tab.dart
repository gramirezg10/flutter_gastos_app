import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spends_app/src/api/spend_api.dart';
import 'package:spends_app/src/models/home_detail_model.dart';
import 'package:spends_app/src/models/spend_detail_model.dart';
import 'package:spends_app/src/models/spend_model.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {});
  }

  final _spendAPI = SpendAPI();
  Map<String, dynamic> _spendsData = {};
  Spend _spends = Spend(
      id: '0',
      date: '01/08/2020',
      description: 'quincena 1',
      amount: 100000,
      sd_homeDetail: [
        HomeDetail(id: '0', HDDesc: 'Efectivo', HDAmount: 150000),
        HomeDetail(id: '1', HDDesc: 'EPM', HDAmount: 150000),
        HomeDetail(id: '2', HDDesc: 'Claro', HDAmount: 150000)
      ],
      sd_spendDetail: [
        SpendDetail(id: '0', SDDesc: 'retiro1', SDAmount: 110000),
        SpendDetail(id: '1', SDDesc: 'retiro2', SDAmount: 120000),
        SpendDetail(id: '2', SDDesc: 'retiro3', SDAmount: 130000)
      ]);
  bool _isFetching = true;
  double _sizeP = 20;
  double _sizeS = 15;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    _spendsData = await _spendAPI.getSpend();
    print(_spendsData);
    // print('spends.runtimeType -- ${spends.runtimeType}'); //para saber el tipo de dato que returna la petición
    setState(() {
      // _spends.addAll(spends);
      // _spendHome.addAll(spends);

      _isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('--- home tab');
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFEEEEEE),
        ),
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: _isFetching
            ? Container(
                color: Colors.white70,
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                ),
              )
            : Column(
                children: [
                  FlatButton(
                      onPressed: () => _loadData,
                      child: Icon(Icons.refresh)),
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        Row(
                          children: [
                            Text(
                              'Descripción: ${_spendsData['description']}',
                              style: TextStyle(fontSize: _sizeP),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('Fecha: ${_spendsData['date']}',
                                style: TextStyle(fontSize: _sizeP))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Valor: ${_spendsData['amount']}',
                                style: TextStyle(fontSize: _sizeP))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Saldo: ${_spendsData['balance']}',
                                style: TextStyle(fontSize: _sizeP))
                          ],
                        ),
                      ])),
                  Divider(height: 20),
                  Text('Gastos generales',
                      style: TextStyle(
                          fontSize: _sizeS, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, i) {
                        final List<dynamic> _spendDetail =
                            _spendsData['sd_spendDetail'];
                        final item = _spendDetail[i];
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Descripción: ${item['SDDesc']}',
                                      style: TextStyle(fontSize: _sizeS))
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Valor: ${item['SDAmount']}',
                                      style: TextStyle(fontSize: _sizeS))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: _spendsData['sd_spendDetail'].length,
                    ),
                  ),
                  Divider(height: 20),
                  Text('Gastos de la casa',
                      style: TextStyle(
                          fontSize: _sizeS, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, i) {
                        final List<dynamic> _homeDetail =
                            _spendsData['sd_homeDetail'];
                        final item = _homeDetail[i];
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Descripción: ${item['HDDesc']}',
                                      style: TextStyle(fontSize: _sizeS))
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Valor: ${item['HDAmount']}',
                                      style: TextStyle(fontSize: _sizeS))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: _spendsData['sd_homeDetail'].length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
