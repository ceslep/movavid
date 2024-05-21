// archivo: url_provider.dart

import 'package:flutter/foundation.dart';

class UrlProvider with ChangeNotifier {
  String _url = 'https://laboratorio.iedeoccidente.com/';

  String get url => _url;

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }
}
