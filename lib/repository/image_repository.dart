import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

// データキャッシュ
Map<String, Uint8List> _imageDataCache = {};

// ネットワーク上から画像を取得するためのIF
class FetchImageInterface {
  // ネットワーク上から画像を取得します(キャッシュあり)
  static Future<Uint8List?> getImageFromURL(String url) async {
    if (_imageDataCache[url] != null) {
      return _imageDataCache[url];
    }
    Uint8List? data;
    try {
      data = (await http.get(Uri.parse(url))).bodyBytes;
      _imageDataCache[url] = data;
    } catch (e) {
      // Do noting
    }
    return data;
  }
}
