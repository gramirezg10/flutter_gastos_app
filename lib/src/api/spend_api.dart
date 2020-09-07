import 'package:http/http.dart' as http;

class SpendAPI {
  
  spend(String token) async {
    print('token from API Class ----$token');
    String url = 'http://192.168.0.11:3000/logingoogle';
    // String url = 'https://reqres.in/api/';
    final http.Response response = await http.post(url,
        body: {"idToken": token});
    // final http.Response response = await http.post('${url}login',
    //     body: {"email": "eve.holt@reqres.in", "password": "cityslicka"});
    print(':::::::::::::::::::::::::::::::::::::::::::');
    print(response.statusCode);
    print(response.body);
    print(':::::::::::::::::::::::::::::::::::::::::::');
  }
}
