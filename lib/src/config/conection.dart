class Connection {

  static String env = 'pdn';

  static createConnection(String path) {
    if (env.toUpperCase() == 'LOCAL') {
      final String uri = 'http://192.168.0.11:3000/$path';
      // final String uri = 'https://reqres.in/$path';
    return uri;
    } else {
      String uri = 'https://gramirez-spends-app-backend.herokuapp.com/$path';
      return uri;
    }
  }
}
