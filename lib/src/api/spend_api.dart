import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spends_app/src/config/conection.dart';
import 'package:spends_app/src/models/spend_model.dart';
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
        final Map<String, dynamic> parsedData = jsonDecode(response.body);
        // print('parsedData.runtimeType ${parsedData.runtimeType}'); //para saber el tipo de dato que retorna
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

  Future getAllSpend() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String _token = prefs.getString('token');
      final dio = Dio();
      final strConnection = Connection.createConnection('spendgetall');

      final response = await dio.post(strConnection,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'idToken': _token,
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }));
      if (response.statusCode == 200) {
        return response.data;
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

  Future postSpend(Spend spend) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String _token = prefs.getString('token');
      final dio = Dio();

      final String stringConnection = Connection.createConnection('spend');
      print(stringConnection);
      List newSpendDetail = _mapperSD(spend.sd_spendDetail);
      List newHomeDetail = _mapperHD(spend.sd_homeDetail);

      final response = await dio.post(stringConnection,
          options:
              Options(contentType: Headers.formUrlEncodedContentType, headers: {
            'idToken': _token,
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
          }),
          queryParameters: {
            'description': spend.description,
            'date': spend.date,
            'amount': spend.amount.toString(),
            'sd_spendDetail': newSpendDetail,
            'sd_homeDetail': newHomeDetail,
          });
      return response.data['ok'];
    } catch (e) {
      print(e);
      return;
    }
  }

  List _mapperSD(List<dynamic> list) {
    if (list.length > 0) {
      final List newList = [];
      list.forEach((item) =>
          newList.add({'SDAmount': item.SDAmount, 'SDDesc': item.SDDesc}));
      return newList;
    }
    return null;
  }

  List _mapperHD(List<dynamic> list) {
    if (list.length > 0) {
      final List newList = [];
      list.forEach((item) =>
          newList.add({'HDAmount': item.HDAmount, 'HDDesc': item.HDDesc}));
      return newList;
    }
    return null;
  }
}
