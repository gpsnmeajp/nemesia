import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
part 'repository_interfaces.freezed.dart';
part 'repository_interfaces.g.dart';
// flutter pub run build_runner build --delete-conflicting-outputs
// flutter run -d chrome

/*
拡張機能を試す方法
https://qiita.com/koji4104/items/65bba670f0519a23b9f6
flutter_tools.stampを削除

Flutter SDKのchrome.dartを開き

--user-data-dir=${userDataDir.path}　を自分のプロファイルに変更
--disable-extensions　をコメントアウト
profile-directoryを追加
*/

typedef Pubkey = String;

@freezed
class Nip07Event with _$Nip07Event {
  const factory Nip07Event({
    required String id, // HEX
    required Pubkey pubkey, //HEX
    // ignore: non_constant_identifier_names
    required int created_at,
    required int kind,
    required List<List<String>> tags,
    required String content,
    required String sig,
  }) = _Nip07Event;
  factory Nip07Event.fromJson(Map<String, Object?> json) =>
      _$Nip07EventFromJson(json);
}

@freezed
abstract class TextNote with _$TextNote {
  const factory TextNote({
    // --- 生データ
    required String rawJson,
    required List<String> relays,
    // --- 基本情報
    required String id, // NIP-19
    required Pubkey pubkey, //NIP-19
    required DateTime createdAt,
    // --- TextNote基本情報
    required String content,
    required List<List<String>> tags,
    // --- TextNote付属情報
    required String? nip36,
    required Metadata? autherMetadata,
    required bool repost,
  }) = _TextNote;
}

@freezed
abstract class Metadata with _$Metadata {
  const factory Metadata({
    // --- 生データ
    required String rawJson,
    required List<String> relays,
    // --- 基本情報
    required String id, // NIP-19
    required Pubkey pubkey, //NIP-19
    required DateTime createdAt,
    // --- Metadata情報(基本)
    required String? name,
    required String? picture,
    required String? about,
    // --- Metadata情報(応用)
    required String? banner,
    required String? website,
    required String? nip05,
    required String? lud16,
    required String? displayName,
  }) = _Metadata;
}

@freezed
abstract class Reaction with _$Reaction {
  const factory Reaction({
    // --- 生データ
    required String rawJson,
    required List<String> relays,
    // --- 基本情報
    required String id, // NIP-19
    required Pubkey pubkey, //NIP-19
    required DateTime createdAt,
    // --- Reaction情報
    required String content,
    required String? emojiUrl,
    required String targetId,
    required String targetPubkey,
  }) = _Reaction;
}

@freezed
abstract class RecommendServer with _$RecommendServer {
  const factory RecommendServer({
    required String address,
    required bool read,
    required bool write,
  }) = _RecommendServer;
}

// リレーから情報を取ってくるためのIF
class RelayRepositoryInterface {
  // リレーに接続・再接続する
  Future<void> connect() async {
    throw UnimplementedError();
  }

  // リレーを取得する
  List<String> getRelay() {
    throw UnimplementedError();
  }

  // リレーを更新する。nullの場合はNIP-07を使用しようとする。
  void setRelay(List<String> relays) {
    throw UnimplementedError();
  }

  // 自己のkeyをセットする。nullの場合はNIP-07を使用しようとする。
  // NIP-19
  void setSelfKey(String? secretKey) {
    throw UnimplementedError();
  }

  // 指定のメモ(あるいはタイムライン)を取得する
  // NIP-01, kind 1
  Future<List<TextNote>> getTextNotes({
    List<String>? ids, //NIP-19
    List<String>? authers, //NIP-19
    List<String>? e, //⚠non-NIP-19
    List<String>? p, //⚠non-NIP-19
    DateTime? since,
    DateTime? until,
    int? limit,
    List<String>? relays,
  }) async {
    throw UnimplementedError();
  }

  // 指定のプロフィールを取得する(認識できない情報は生jsonに含まれる)
  // NIP-01, kind 0
  // pubkey: NIP-19
  Future<Map<Pubkey, Metadata>> getMetadatas(List<Pubkey>? pubkeys) async {
    throw UnimplementedError();
  }

  // 指定のフォローリストを取得する
  // NIP-02, kind 3
  // pubkey: NIP-19
  Future<List<Pubkey>> getContactList(Pubkey pubkey) async {
    throw UnimplementedError();
  }

  // 指定の推奨リレーリストを取得する
  // NIP-01, kind 2
  // pubkey: NIP-19
  /*
  Future<List<RecommendServer>> getRecommendServer(Pubkey pubkey) async {
    throw UnimplementedError();
  }
  */

  // メモを投稿する
  // NIP-01, kind 1
  Future<void> postMyTextNote(String content, List<List<String>> tags) async {
    throw UnimplementedError();
  }

  // 自己プロフィールを投稿する(認識できない情報は生jsonに含まれているためそれを使用する)
  // NIP-01, kind 0
  /*
  Future<void> postMyMetadata(Metadata metadata) async {
    throw UnimplementedError();
  }
  */

  // リアクションを投稿する
  // NIP-25, kind 7
  // noteId: NIP-19
  Future<void> postReaction({
    required Pubkey pubkey,
    required String noteId,
    required String reaction,
    String? emojiUrl,
  }) async {
    throw UnimplementedError();
  }

  // リポストを投稿する
  // NIP-18, kind 6
  Future<void> postRepost(TextNote textNote) async {
    throw UnimplementedError();
  }
}
