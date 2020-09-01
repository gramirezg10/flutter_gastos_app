import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {
  List<dynamic> options = [];
  final String pathFile = 'data/spen_data.json';

  _MenuProvider(){
    // loadData();
  }

  Future<List<dynamic>> loadData() async {
    final res = await rootBundle.loadString(pathFile);
        Map dataMap = json.decode(res);
        options = dataMap['rutas'];
      return options;
  }
}

final menuProvider = new _MenuProvider();