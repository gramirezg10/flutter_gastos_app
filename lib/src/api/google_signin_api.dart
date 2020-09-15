import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:spends_app/src/util/conection.dart';

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

      final signInWithGoogleEndpoint = Connection.createConnection('logingoogle');
      final response = await http
          .post(signInWithGoogleEndpoint, body: {'idToken': googleKey.idToken});

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
