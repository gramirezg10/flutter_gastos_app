class Connection {

  static String env = 'local';

  static createConnection(String path) {
    if (env.toUpperCase() == 'LOCAL') {
      final String uri = 'http://192.168.0.11:3000/$path';
      // final String uri = 'https://reqres.in/$path';
    return uri;
    } else {
      Uri uri = Uri(
          scheme: 'https',
          host: 'gramirez-spends-app-backend.herokuapp.com',
          path: '/$path');
      return uri;
    }
  }
}
