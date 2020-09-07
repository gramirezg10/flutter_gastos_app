import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SpendAPI {
  Future<List<dynamic>> getSpend() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String _token = prefs.getString('token');

      // String url = 'http://192.168.0.11:3000/getspend';
      // final http.Response response = await http.post(url,
      //     body: {"idToken": token});

      // // Server
      final signInWithGoogleEndpoint = Uri(
          scheme: 'https',
          host: 'gramirez-spends-app-backend.herokuapp.com',
          path: '/getspend');
      final http.Response response = await http.post(signInWithGoogleEndpoint, body: {'idToken': _token});
      if (response.statusCode == 200) {
        final parsedData = jsonDecode(response.body);
        // print(parsedData['spendsDB'].runtimeType); para saber el tipo de dato que retorna
        return parsedData['spendsDB'];
      } else {
        print('statusCode: ${response.statusCode}. class spend_api.dart: error en el getSpend');
        return [];
      }

    } catch (e) {
      print(e);
      return [];
    }
  }
}
