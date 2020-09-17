import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:spends_app/src/api/spend_api.dart';
import 'package:spends_app/src/widgets/loader.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {});
  }

  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final _spendAPI = SpendAPI();
  Map<String, dynamic> _spendsData = {};

  bool _isFetching = true;
  double _sizeP = 20;
  double _sizeS = 15;
  TextStyle _textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() => _isFetching = true);
    _spendsData = await _spendAPI.getSpend();
    // print(_spendsData);
    setState(() => _isFetching = false);
  }

  @override
  Widget build(BuildContext context) {
    print('--- home tab');
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFF0F4F4),
        ),
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: _isFetching
            ? Loader()
            : Column(
                children: [
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fecha: ${_spendsData['date']}',
                                style: TextStyle(fontSize: _sizeP)),
                            _refresh(),
                          ],
                        ),
                        Text('Descripción: ${_spendsData['description']}',
                            style: TextStyle(fontSize: _sizeP)),
                        Text('Valor: ${oCcy.format(_spendsData['amount'])}',
                            style: TextStyle(fontSize: _sizeP)),
                        Text('Saldo: ${oCcy.format(_spendsData['balance'])}',
                            style: TextStyle(
                                fontSize: _sizeP,
                                color: _spendsData['balance'] < 0
                                    ? Colors.red
                                    : Colors.black))
                      ])),
                  Divider(height: 20),
                  _getBalanceDetail(
                      'Gastos generales', _spendsData['balanceSpendDetail']),
                  _buildSpendDetail(),
                  Divider(height: 20),
                  _getBalanceDetail(
                      'Gastos de la casa', _spendsData['balanceHomeDetail']),
                  _buildHomeDetail()
                ],
              ),
      ),
    );
  }

  Widget _getBalanceDetail(String _desc, int _amount) {
    return Container(
      padding: EdgeInsetsDirectional.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(_desc, style: _textStyle),
          Text('Total: ${oCcy.format(_amount)}', style: _textStyle),
        ],
      ),
    );
  }

  Widget _buildSpendDetail() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          final item = _spendsData['sd_spendDetail'][i];
          return Container(
            child: ListTile(
              visualDensity: VisualDensity.compact,
              enabled: true,
              contentPadding: EdgeInsets.zero,
              title: Text('Valor: ${oCcy.format(item['SDAmount'])}',
                  style: TextStyle(fontSize: _sizeS)),
              subtitle: Text('Descripción: ${item['SDDesc']}',
                  style: TextStyle(fontSize: _sizeS)),
            ),
          );
        },
        itemCount: _spendsData['sd_spendDetail'].length,
      ),
    );
  }

  Widget _buildHomeDetail() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          final item = _spendsData['sd_homeDetail'][i];
          return Container(
            child: ListTileTheme(
              selectedColor: Colors.blue,
              child: ListTile(
                visualDensity: VisualDensity.compact,
                enabled: true,
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  print('object');
                },
                title: Text('Valor: ${oCcy.format(item['HDAmount'])}',
                    style: TextStyle(fontSize: _sizeS)),
                subtitle: Text('Descripción: ${item['HDDesc']}',
                    style: TextStyle(fontSize: _sizeS)),
              ),
            ),
          );
        },
        itemCount: _spendsData['sd_homeDetail'].length,
      ),
    );
  }

  Widget _refresh() {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Icon(
          Icons.refresh,
          color: Colors.blue,
        ),
        onPressed: () => _loadData());
  }
}
