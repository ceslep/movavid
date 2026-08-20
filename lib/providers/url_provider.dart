// archivo: url_provider.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class UrlProvider with ChangeNotifier {
  static const String _defaultUrl = 'https://laboratorio.iedeoccidente.com/';
  String _url = _defaultUrl;

  String get url => _url;

  void setUrl(String url) {
    String limpiada = url.trim();
    if (limpiada.isEmpty) return;
    if (!limpiada.endsWith('/')) limpiada = '$limpiada/';
    _url = limpiada;
    notifyListeners();
    _persistir();
  }

  void resetUrl() {
    _url = _defaultUrl;
    notifyListeners();
    _persistir();
  }

  Future<void> load() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return;
    try {
      final Directory dir = await getApplicationSupportDirectory();
      final File file = File('${dir.path}/config.json');
      if (await file.exists()) {
        final Map<String, dynamic> data =
            json.decode(await file.readAsString()) as Map<String, dynamic>;
        final String? guardada = data['url'] as String?;
        if (guardada != null && guardada.isNotEmpty) {
          _url = guardada;
          notifyListeners();
        }
      }
    } catch (_) {}
  }

  Future<void> _persistir() async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) return;
    try {
      final Directory dir = await getApplicationSupportDirectory();
      if (!await dir.exists()) await dir.create(recursive: true);
      final File file = File('${dir.path}/config.json');
      await file.writeAsString(json.encode({'url': _url}));
    } catch (_) {}
  }
}