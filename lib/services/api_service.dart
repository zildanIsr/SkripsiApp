class APIService {
  final String _url = "https://flutter-maps-381907.et.r.appspot.com/";

  String getURL(String api) {
    String newUrl = _url + api;

    return newUrl;
  }
}
