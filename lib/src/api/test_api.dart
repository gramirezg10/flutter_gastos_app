import 'package:dio/dio.dart';
import 'package:spends_app/src/config/conection.dart';

class TestAPI {
  Future getTest() async {
    // final strConection = Connection.createConnection('spendgetall');
    // final dio = Dio();

    // Future<SpendResponse> getSpend() async {
    //   try {
    //     Response response = await dio.get(strConection);
    //     return SpendResponse.fromJson(response.data);
    //   } catch (error, stacktrace) {
    //     print("Exception occured: $error stackTrace: $stacktrace");
    //     return SpendResponse.withError("$error");
    //   }
    // }
  }

  Future post() async {
    try {
      final strConection = Connection.createConnection('api/users');
      final dio = Dio();

      final Response<dynamic> response = await dio
          .post(strConection, data: {"name": "morpheus", "job": "leader"});
      if (response.statusCode == 200) {
        final dynamic parsedData = response;
        print(
            'parsedData.runtimeType ${parsedData.runtimeType}'); //para saber el tipo de dato que retorna
        print(parsedData);
        return 'ok';
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
