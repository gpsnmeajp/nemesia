import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:flutter/foundation.dart';
part 'metadata_repository.freezed.dart';

@freezed
abstract class OPGMetaData with _$OPGMetaData {
  const factory OPGMetaData({
    required String title,
    required Uint8List? image,
  }) = _OPGMetaData;
}

// データキャッシュ
Map<String, OPGMetaData> _opgMetaDataCache = {};

// OGPメタ情報を取得するためのIF
class OGPMetadataInterface {
  // OGP Metadataを取得します(キャッシュあり)
  static Future<OPGMetaData?> getMetaDataFromURL(String url) async {
    if (_opgMetaDataCache[url] != null) {
      return _opgMetaDataCache[url];
    }

    OPGMetaData? ogp;
    try {
      var ogpRes = await MetadataFetch.extract(url);
      var ogpImageUrl = ogpRes?.image;
      var ogpText = ogpRes?.title ?? "";

      Uint8List? data;
      if (ogpImageUrl != null) {
        data = (await http.get(Uri.parse(ogpImageUrl))).bodyBytes;
      }
      ogp = OPGMetaData(title: ogpText, image: data);
      _opgMetaDataCache[url] = ogp;
    } catch (e) {
      // Do noting
    }

    return ogp;
  }
}
