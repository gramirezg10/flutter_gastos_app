import 'dart:convert';
import 'package:http/http.dart' as http;

class TestAPI {
  Future getTestAPI() async {
    try {
      final signInWithGoogleEndpoint = Uri(
          scheme: 'https',
          host: 'reqres.in',
          path: 'api/unknown/2');
      final http.Response response = await http.get(signInWithGoogleEndpoint);
      if (response.statusCode == 200) {
        final dynamic parsedData = jsonDecode(response.body);
        print('parsedData.runtimeType ${parsedData.runtimeType}'); //para saber el tipo de dato que retorna
        print(parsedData);
        return 'ok';
      } else {
        print('statusCode: ${response.statusCode}. class test_api.dart: error en el getTestAPI');
        return {};
      }

    } catch (e) {
      print(e);
      return {};
    }
  }
}
