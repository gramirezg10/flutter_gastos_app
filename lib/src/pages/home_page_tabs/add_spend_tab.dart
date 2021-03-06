import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:spends_app/src/api/spend_api.dart';
import 'package:spends_app/src/models/home_detail_model.dart';
import 'package:spends_app/src/models/spend_detail_model.dart';
import 'package:spends_app/src/models/spend_model.dart';
import 'package:spends_app/src/util/dialogs.dart';

class AddSpendTab extends StatefulWidget {
  @override
  _AddSpendTabState createState() => _AddSpendTabState();
}

class _AddSpendTabState extends State<AddSpendTab> {
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode _fnDescription = FocusNode();
  FocusNode _fnAmount = FocusNode();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  Spend _spend = Spend();

  // final List<SpendDetail> _listSpendDetail_ = [];
  // final List<HomeDetail> _listSpendHomeDetail_ = [];

  List<SpendDetail> _listSpendDetail = [];
  List<HomeDetail> _listSpendHomeDetail = [];

  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerDesc = new TextEditingController();
  TextEditingController _controllerAmount = new TextEditingController();
  TextEditingController _controllerSDDesc = new TextEditingController();
  TextEditingController _controllerSDAmount = new TextEditingController();
  TextEditingController _controllerHDDesc = new TextEditingController();
  TextEditingController _controllerHDAmount = new TextEditingController();

  double _totalSpend = 0;
  double _totalHome = 0;

  double _sizeP = 20;
  double _sizeS = 15;

  bool init = true;

  TextStyle _textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

// @override
//   void initState() {
//     super.initState();
//     _controllerAmount.text = '0';
//   }

  @override
  Widget build(BuildContext context) {
    print('--- add spend tab');
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Form(
          autovalidate: false,
          key: _formKey,
          child: Column(
            children: [
              Text('Descripción generar del ingreso',
                  style:
                      TextStyle(fontSize: _sizeP, fontWeight: FontWeight.bold)),
              // Fecha del ingreso
              SizedBox(height: 20),
              _ingressDate(),
              SizedBox(height: 10),
              _ingressDescription(),
              SizedBox(height: 10),
              _ingressAmount(),
              if (!init)
                Container(
                  padding: EdgeInsets.symmetric(),
                  width: double.infinity,
                  child: Column(children: [
                    if (_controllerAmount.text.isNotEmpty)
                      Text(
                          'Ingreso: ${oCcy.format(double.parse(_controllerAmount.text))}',
                          style: _textStyle),
                    if (_controllerAmount.text.isNotEmpty)
                      Text('Saldo  : ${_getBalancePayment()}',
                          style: _textStyle),
                  ]),
                ),
              Divider(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Gastos generales', style: _textStyle),
                      Text('Total: ${oCcy.format(_totalSpend.toInt())}',
                          style: _textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      _clearListSpendDetail(),
                      _btnAddSpendDetail(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              _spendDetailDescAndAmount(),
              (_listSpendDetail.length > 0)
                  ? Divider(height: 40, thickness: 1)
                  : Text(''),
              _listTileSDGenerator(),
              (_listSpendDetail.length > 0)
                  ? Divider(height: 40, thickness: 1)
                  : Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('Gastos de la casa', style: _textStyle),
                      Text('Total: ${oCcy.format(_totalHome.toInt())}',
                          style: _textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      _clearListSpendHomeDetail(),
                      _btnAddSpendHomeDetail(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              _spendHomeDetailDescAndAmount(),
              (_listSpendHomeDetail.length > 0)
                  ? Divider(height: 40, thickness: 1)
                  : Text(''),
              _listTileHDGenerator(),
              (_listSpendHomeDetail.length > 0)
                  ? Divider(height: 40, thickness: 1)
                  : Text(''),

              CupertinoButton(
                child: Text('Listo!'),
                onPressed: _submit,
                color: Colors.blue[200],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ingressDate() {
    return TextFormField(
      autofocus: false,
      controller: _controllerDate,
      decoration: InputDecoration(
        labelText: 'Fecha del ingreso',
        hintText: 'DD/MM/AAAA',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Container(
            padding: EdgeInsets.all(10),
            width: 10,
            height: 10,
            child: SvgPicture.asset(
              'assets/icons/calendar.svg',
              color: Colors.black54,
            )),
      ),
      keyboardType: TextInputType.datetime,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _fnDescription.nextFocus(),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  Widget _ingressDescription() {
    return TextFormField(
      autofocus: false,
      controller: _controllerDesc,
      decoration: InputDecoration(
          labelText: 'Descripción del ingreso',
          hintText: 'Inversión / Pago',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Container(
              padding: EdgeInsets.all(10),
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                'assets/icons/text.svg',
                color: Colors.black87,
              ))),
      keyboardType: TextInputType.name,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
      validator: (text) => _validateDescription(),
      focusNode: _fnDescription,
      onFieldSubmitted: (text) {
        _fnAmount.nextFocus();
      },
    );
  }

  Widget _ingressAmount() {
    return TextFormField(
      controller: _controllerAmount,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Monto del ingreso',
          hintText: "1'000.000",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Container(
              padding: EdgeInsets.all(10),
              width: 10,
              height: 10,
              child: SvgPicture.asset(
                'assets/icons/money.svg',
                color: Colors.black87,
              ))),
      keyboardType: TextInputType.number,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        setState(() {
          if (_controllerAmount.text.isNotEmpty)
            init = false;
          else
            init = true;
        });
      },
      validator: (text) => _validateAmount(),
      focusNode: _fnAmount,
      // onFieldSubmitted: (text) {
      //   _focusNodePassword.nextFocus();
      // },
    );
  }

  String _getBalancePayment() {
    if (_controllerAmount.text.isNotEmpty) {
      return oCcy.format(
          double.parse(_controllerAmount.text) - (_totalHome + _totalSpend));
    }
    return '0';
  }

  // Spend details
  Widget _spendDetailDescAndAmount() {
    return Column(
      children: [
        TextFormField(
          autofocus: false,
          controller: _controllerSDDesc,
          decoration: InputDecoration(
            labelText: 'Descripción gasto',
            hintText: 'Gasto',
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          keyboardType: TextInputType.name,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.next,
          // validator: (text) => _validateSDDesc(),
          // focusNode: _fnDescription,
          onFieldSubmitted: (text) {
            _fnAmount.nextFocus();
          },
        ),
        TextFormField(
          autofocus: false,
          controller: _controllerSDAmount,
          decoration: InputDecoration(
            labelText: 'Monto del gasto',
            hintText: "100.000",
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
          keyboardType: TextInputType.number,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.next,
          // validator: (text) => _validateSDAmount(),
          // focusNode: _fnAmount,
          // onFieldSubmitted: (text) {
          //   _focusNodePassword.nextFocus();
          // },
        )
      ],
    );
  }

  Widget _spendHomeDetailDescAndAmount() {
    return Column(
      children: [
        TextFormField(
          autofocus: false,
          controller: _controllerHDDesc,
          decoration: InputDecoration(
            labelText: 'Descripción gasto casa',
            hintText: 'Mercado',
          ),
          keyboardType: TextInputType.name,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.next,
          // validator: (text) => _validateHDDesc(),
          // focusNode: _fnDescription,
          // onFieldSubmitted: (text) {
          //   _fnAmount.nextFocus();
          // },
        ),
        TextFormField(
          autofocus: false,
          controller: _controllerHDAmount,
          decoration: InputDecoration(
            labelText: 'Monto del gasto',
            hintText: "100.000",
          ),
          keyboardType: TextInputType.number,
          keyboardAppearance: Brightness.light,
          textInputAction: TextInputAction.next,
          // validator: (text) => _validateHDAmount(),
          // focusNode: _fnAmount,
          // onFieldSubmitted: (text) {
          //   _focusNodePassword.nextFocus();
          // },
        )
      ],
    );
  }

  Widget _btnAddSpendDetail() {
    return Container(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
          child: SvgPicture.asset(
            'assets/icons/add.svg',
            width: 30,
            color: Colors.black,
          ),
          onPressed: _addSDDescAmount),
    );
  }

  Widget _clearListSpendDetail() {
    return Container(
      child: CupertinoButton(
          child: SvgPicture.asset(
            'assets/icons/delete.svg',
            width: 30,
            color: Colors.black,
          ),
          onPressed: _clearListSD),
    );
  }

  Widget _btnAddSpendHomeDetail() {
    return Container(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
          child: SvgPicture.asset(
            'assets/icons/add.svg',
            width: 30,
            color: Colors.black,
          ),
          onPressed: _addHDDescAmount),
    );
  }

  Widget _clearListSpendHomeDetail() {
    return Container(
      child: CupertinoButton(
          child: SvgPicture.asset(
            'assets/icons/delete.svg',
            width: 30,
            color: Colors.black,
          ),
          // onPressed: (){}),
          onPressed: _clearListHD)
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2025));

    if (picked != null) {
      setState(() {
        final aux = picked.toString().substring(0, 10).split('-');
        _spend.date = '${aux[2]}/${aux[1]}/${aux[0]}';
        _controllerDate.text = _spend.date;
      });
    }
  }

  String _validateDescription() {
    if (_controllerDesc.text.isNotEmpty) return null;
    return 'Descripción no puede ser vacía';
  }

  String _validateAmount() {
    if (_controllerAmount.text.isNotEmpty &&
        double.parse(_controllerAmount.text) > 0) return null;
    return 'Monto tiene que ser mayor a 0';
  }

  // String _validateSDDesc() {
  //   if (_controllerSDDesc.text.isNotEmpty) return null;
  //   return 'Descripción del detalle no puede ser vacía';
  // }

  // String _validateSDAmount() {
  //   if (_controllerSDAmount.text.isNotEmpty &&
  //       double.parse(_controllerSDAmount.text) > 0) return null;
  //   return 'Monto tiene que ser mayor a 0';
  // }

  // String _validateHDDesc() {
  //   if (_controllerHDDesc.text.isNotEmpty) return null;
  //   return 'Descripción del detalle no puede ser vacía';
  // }

  // String _validateHDAmount() {
  //   if (_controllerHDAmount.text.isNotEmpty &&
  //       double.parse(_controllerSDAmount.text) > 0) return null;
  //   return 'Monto tiene que ser mayor a 0';
  // }

  void _addSDDescAmount() {
    if (_controllerSDDesc.text.isNotEmpty &&
        double.parse(_controllerSDAmount.text) > 0) {
      SpendDetail _spendD = SpendDetail();
      _spendD.SDDesc = _controllerSDDesc.text;
      _spendD.SDAmount = double.parse(_controllerSDAmount.text);
      _listSpendDetail.add(_spendD);
      // _listSpendDetail
      //     .add('${_controllerSDDesc.text}/${_controllerSDAmount.text}');

      _totalSpend = _totalSpend + _spendD.SDAmount;
      _controllerSDDesc.clear();
      _controllerSDAmount.clear();
      setState(() => _listTileSDGenerator());
    } else {
      print('objeto vacío');
      return;
    }
  }

  void _clearListSD() {
    setState((){
      _listSpendDetail.clear();
      _totalSpend = 0;
    });
    return;
  }

  void _clearListHD() {
    setState((){
      _listSpendHomeDetail.clear();
      _totalHome = 0;
    });
    return;
  }

  void _addHDDescAmount() {
    if (_controllerHDDesc.text.isNotEmpty &&
        double.parse(_controllerHDAmount.text) > 0) {
      HomeDetail _spendHD = HomeDetail();
      _spendHD.HDDesc = _controllerHDDesc.text;
      _spendHD.HDAmount = double.parse(_controllerHDAmount.text);
      _listSpendHomeDetail.add(_spendHD);
      // _listSpendHomeDetail
      //     .add('${_controllerHDDesc.text}/${_controllerHDAmount.text}');

      _totalHome = _totalHome + double.parse(_controllerHDAmount.text);
      _controllerHDDesc.clear();
      _controllerHDAmount.clear();
      setState(() => _listTileHDGenerator());
    } else {
      print('objeto vacío');
      return;
    }
  }

  Widget _listTileSDGenerator() {
    List<Widget> _list = [];
    _listSpendDetail.forEach((item) {
      final Widget _listTileItem = ListTile(
        dense: true,
        enabled: false,
        visualDensity: VisualDensity.compact,
        title: Text('${oCcy.format(item.SDAmount)}'),
        subtitle: Text('${item.SDDesc}'),
      );
      _list..add(_listTileItem);
    });
    return Column(
      children: _list,
    );
  }

  Widget _listTileHDGenerator() {
    List<Widget> _list = [];
    _listSpendHomeDetail.forEach((item) {
      final Widget _listTileItem = ListTile(
        dense: true,
        enabled: false,
        visualDensity: VisualDensity.compact,
        title: Text('${oCcy.format(item.HDAmount)}'),
        subtitle: Text('${item.HDDesc}'),
      );
      _list..add(_listTileItem);
    });
    return Column(
      children: _list,
    );
  }

  // ::::::::::::::

  void _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      final isOk = await Dialogs.confirm(context,
          title: '¿Desea registrar ya su ingreso?');
      if (isOk) {
        _spend.description = _controllerDesc.text;
        _spend.amount = double.parse(_controllerAmount.text);
        _spend.sd_spendDetail = _listSpendDetail;
        _spend.sd_homeDetail = _listSpendHomeDetail;
        _createSpend(context, _spend);
      }
    } else
      return;
    return;
  }

  _createSpend(BuildContext context, Spend spend) async {
    final _spendAPI = SpendAPI();
    final _spendsData = await _spendAPI.postSpend(spend);
    print('_SpendCreated?________________ $_spendsData');
    if (_spendsData) {
      // Dialogs.alert(context,
      //     title: 'Ingreso creado',
      //     body: 'Por favor cierre y vuelva a ingresar a la app');
      setState(() {
        _controllerDate.clear();
        _controllerDesc.clear();
        _controllerAmount.clear();
        _listSpendDetail.clear();
        _listSpendHomeDetail.clear();
        _totalSpend = 0;
        _totalHome = 0;
      });
    }
  }
}
