import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInApi {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  static Future<String> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;

      //validar el token con el backend

      // Local
      String url = 'http://192.168.0.11:3000/logingoogle';
      final http.Response response =
          await http.post(url, body: {'idToken': googleKey.idToken});
      print(response.body);

      // // Server
      // final signInWithGoogleEndpoint =
      //     Uri(scheme: 'https', host: 'url de heroku', path: '/logingoogle');
      // final response = await http
      //     .post(signInWithGoogleEndpoint, body: {'idToken': googleKey.idToken});

      //
      return response.body;
    } catch (e) {
      print('-----catch (account) en google signin-----');
      print(e);
      return null;
    }
  }

  static Future<GoogleSignInAccount> signOut() async {
    await _googleSignIn.signOut();
  }
}
