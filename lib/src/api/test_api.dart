import 'package:dio/dio.dart';
import 'package:spends_app/src/config/conection.dart';

class TestAPI {
  // Future getTest() async {
  //   final strConection = Connection.createConnection('smoketest');
  //   final dio = Dio();

  //   // Future<SpendResponse> getSpend() async {
  //   //   try {
  //   //     Response response = await dio.get(strConection);
  //   //     return SpendResponse.fromJson(response.data);
  //   //   } catch (error, stacktrace) {
  //   //     print("Exception occured: $error stackTrace: $stacktrace");
  //   //     return SpendResponse.withError("$error");
  //   //   }
  //   // }
  // }

  Future post() async {
    try {
      final strConection = Connection.createConnection('test');
      final dio = Dio();

      FormData formData = FormData.fromMap({
        'param1': '1',
        'param2': '2',
        "sd_homeDetail": [
          {"HDDesc": "Claro", "HDAmount": 119000},
          {"HDDesc": "EPM", "HDAmount": 299000}
        ],
        "sd_spendDetail": [
          {"SDDesc": "Varios 1", "SDAmount": 120000},
          {"SDDesc": "Varios 2", "SDAmount": 120000},
          {"SDDesc": "Apto", "SDAmount": 420000},
          {"SDDesc": "A fidu", "SDAmount": 80000}
        ]
      });

      print(strConection);

      final Response<dynamic> response = await dio.post(
        strConection,
        data: formData,
        queryParameters: {
        'param1': '1',
        'param2': '2',
        "sd_homeDetail": [
          {"HDDesc": "Claro", "HDAmount": 119000},
          {"HDDesc": "EPM", "HDAmount": 299000}
        ],
        "sd_spendDetail": [
          {"SDDesc": "Varios 1", "SDAmount": 120000},
          {"SDDesc": "Varios 2", "SDAmount": 120000},
          {"SDDesc": "Apto", "SDAmount": 420000},
          {"SDDesc": "A fidu", "SDAmount": 80000}
        ]
      },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      if (response.statusCode == 200) {
        final dynamic parsedData = response;
        print(parsedData.data['ok']);
        return parsedData.data['ok'];
      } else {
        print(
            'statusCode: ${response.statusCode}. class test_api.dart: error en el post');
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
