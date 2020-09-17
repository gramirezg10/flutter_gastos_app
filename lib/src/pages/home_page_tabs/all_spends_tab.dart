import 'package:flutter/material.dart';
import 'package:spends_app/src/api/spend_api.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    // _spendsData = await _spendAPI.getAllSpend();
    final result = await _spendAPI.getAllSpend();
    if (result['ok']) {
      resultData = result['spendRes'];
      print(resultData);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('--- all spends tab');

    return Container(
      // color: Colors.black12,
      padding: EdgeInsets.zero,
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.only(left: 10, bottom: 5, right: 10),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            // padding: EdgeInsets.only(bottom: 300),
            child: Column(
              children: [
                Container(
                  // color: Colors.black26,
                  width: double.infinity,
                  height: constraints.maxHeight * 0.09,
                  // height: 100,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('AllSpends tab content!!______'),
                          FlatButton(
                              onPressed: () {
                                print('click en refresh');
                                _loadData();
                                setState(() {});
                              },
                              child: Icon(Icons.refresh)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(),
                Container(
                    // color: Color(0xB7B4B4),
                    padding: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: constraints.maxHeight * .95,
                    child: ListView.builder(
                        itemBuilder: (_, i) {
                          final Map<String, dynamic> item = resultData[i];

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFEEEEEE),
                            ),
                            alignment: Alignment.center,
                            width: 120,
                            height: 150,
                            margin:
                                EdgeInsets.all(constraints.maxHeight * 0.015),
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                  child: Column(
                                    
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Descripción: ${item['description']}',
                                          style: TextStyle(fontSize: _sizeS),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Fecha: ${item['date']}',
                                            style: TextStyle(fontSize: _sizeS))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Valor: ${item['amount']}',
                                            style: TextStyle(fontSize: _sizeS))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Saldo: ${item['balance']}',
                                            style: TextStyle(fontSize: _sizeS))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Gastos generales: ${item['balanceSpendDetail']}',
                                            style: TextStyle(fontSize: _sizeS))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Gastos casa: ${item['balanceHomeDetail']}',
                                            style: TextStyle(fontSize: _sizeS))
                                      ],
                                    ),
                                  ])),
                            ]),
                          );
                        },
                        itemCount: resultData.length))
              ],
            ),
          ),
        );
      }),
    );
  }
}
