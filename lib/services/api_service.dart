class APIService {
  //final String _url = "https://flutter-maps-381907.et.r.appspot.com/";
  //final String _url = "http://192.168.43.148:3500/";
  final String _url = "http://10.0.2.2:3500/";

  String getURL(String api) {
    String newUrl = _url + api;

    return newUrl;
  }
}
