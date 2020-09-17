import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spends_app/src/api/spend_api.dart';
import 'package:spends_app/src/widgets/loader.dart';

class AllSpendsTab extends StatefulWidget {
  @override
  _AllSpendsTabState createState() => _AllSpendsTabState();
}

class _AllSpendsTabState extends State<AllSpendsTab> {
  final _spendAPI = SpendAPI();
  Map<String, dynamic> _spendsData = {};
  List resultData = [];

  double _sizeP = 20;
  double _sizeS = 15;
  bool _isFetching = true;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    setState(() => _isFetching = true);
    refreshKey.currentState?.show();
    final result = await _spendAPI.getAllSpend();
    if (result['ok']) {
      setState(() {
        resultData = result['spendRes'];
        // print(resultData);
        _isFetching = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('--- all spends tab');

    return Container(
      padding: EdgeInsets.zero,
      child: LayoutBuilder(builder: (context, constraints) {
        return resultData != null
            ? RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
                  alignment: Alignment.center,
                  child: _isFetching
                      ? Loader()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: constraints.maxHeight * 0.09,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Ultimos 20 registros, deslice aquí para refrescar',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            color: Colors.black54)),
                                  ],
                                ),
                              ),
                              SizedBox(),
                              Container(
                                  height: constraints.maxHeight * .91,
                                  child: ListView.builder(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (_, i) {
                                        final Map<String, dynamic> item =
                                            resultData[i];
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xFFF6F6F6),
                                          ),
                                          margin: EdgeInsets.all(
                                              constraints.maxHeight * 0.010),
                                          child: Column(children: [
                                            Container(
                                                padding: EdgeInsets.all(15),
                                                child: Column(children: [
                                                  Text(
                                                    'Descripción: ${item['description']}',
                                                    style: TextStyle(
                                                        fontSize: _sizeS),
                                                  ),
                                                  Text('Fecha: ${item['date']}',
                                                      style: TextStyle(
                                                          fontSize: _sizeS)),
                                                  Text(
                                                      'Valor: ${oCcy.format(item['amount'])}',
                                                      style: TextStyle(
                                                          fontSize: _sizeS)),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Saldo: ${oCcy.format(item['balance'])}',
                                                      style: TextStyle(
                                                          fontSize: _sizeS,
                                                          color:
                                                              item['balance'] <
                                                                      0
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .black)),
                                                  Text(
                                                      'Gastos generales: ${oCcy.format(item['balanceSpendDetail'])}',
                                                      style: TextStyle(
                                                          fontSize: _sizeS)),
                                                  Text(
                                                      'Gastos casa: ${oCcy.format(item['balanceHomeDetail'])}',
                                                      style: TextStyle(
                                                          fontSize: _sizeS))
                                                ])),
                                          ]),
                                        );
                                      },
                                      itemCount: resultData.length))
                            ],
                          ),
                        ),
                ))
            : Loader();
      }),
    );
  }
}
