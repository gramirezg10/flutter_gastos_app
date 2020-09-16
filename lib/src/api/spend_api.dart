import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spends_app/src/models/spend_model.dart';
import 'package:spends_app/src/config/conection.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SpendAPI {
  Future<Map<String, dynamic>> getSpend() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String _token = prefs.getString('token');

      final signInWithGoogleEndpoint =
          Connection.createConnection('spendgetlast');

      final http.Response response =
          await http.post(signInWithGoogleEndpoint, body: {'idToken': _token});
      if (response.statusCode == 200) {
        // final Map<Spend, dynamic> parsedData = jsonDecode(response.body);
        final Map<String, dynamic> parsedData = jsonDecode(response.body);
        print(
            'parsedData.runtimeType ${parsedData.runtimeType}'); //para saber el tipo de dato que retorna
        print(parsedData['spendRes']);
        return parsedData['spendRes'];
      } else {
        print(
            'statusCode: ${response.statusCode}. class spend_api.dart: error en el getSpend');
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future postSpend(dynamic spend, List _spList, List _hdList) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String _token = prefs.getString('token');
      final dio = Dio();

      final String stringConnection = Connection.createConnection('spend');
      print(stringConnection);

      final response = await dio.post(stringConnection,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'idToken': _token,
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }),
          data: {
            'description': spend.description,
            'date': spend.date,
            'amount': spend.amount.toString(),
            'sd_spendDetail': jsonEncode(_spList),
            'sd_homeDetail': jsonEncode(_hdList),
          });
      print(response.data['msg']);
      return response.data['spend'];
    } catch (e) {
      print(e);
      return;
    }
  }
}
