// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repository_interfaces.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Nip07Event _$Nip07EventFromJson(Map<String, dynamic> json) {
  return _Nip07Event.fromJson(json);
}

/// @nodoc
mixin _$Nip07Event {
  String get id => throw _privateConstructorUsedError; // HEX
  String get pubkey => throw _privateConstructorUsedError; //HEX
// ignore: non_constant_identifier_names
  int get created_at => throw _privateConstructorUsedError;
  int get kind => throw _privateConstructorUsedError;
  List<List<String>> get tags => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get sig => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Nip07EventCopyWith<Nip07Event> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Nip07EventCopyWith<$Res> {
  factory $Nip07EventCopyWith(
          Nip07Event value, $Res Function(Nip07Event) then) =
      _$Nip07EventCopyWithImpl<$Res, Nip07Event>;
  @useResult
  $Res call(
      {String id,
      String pubkey,
      int created_at,
      int kind,
      List<List<String>> tags,
      String content,
      String sig});
}

/// @nodoc
class _$Nip07EventCopyWithImpl<$Res, $Val extends Nip07Event>
    implements $Nip07EventCopyWith<$Res> {
  _$Nip07EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pubkey = null,
    Object? created_at = null,
    Object? kind = null,
    Object? tags = null,
    Object? content = null,
    Object? sig = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sig: null == sig
          ? _value.sig
          : sig // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_Nip07EventCopyWith<$Res>
    implements $Nip07EventCopyWith<$Res> {
  factory _$$_Nip07EventCopyWith(
          _$_Nip07Event value, $Res Function(_$_Nip07Event) then) =
      __$$_Nip07EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pubkey,
      int created_at,
      int kind,
      List<List<String>> tags,
      String content,
      String sig});
}

/// @nodoc
class __$$_Nip07EventCopyWithImpl<$Res>
    extends _$Nip07EventCopyWithImpl<$Res, _$_Nip07Event>
    implements _$$_Nip07EventCopyWith<$Res> {
  __$$_Nip07EventCopyWithImpl(
      _$_Nip07Event _value, $Res Function(_$_Nip07Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pubkey = null,
    Object? created_at = null,
    Object? kind = null,
    Object? tags = null,
    Object? content = null,
    Object? sig = null,
  }) {
    return _then(_$_Nip07Event(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as int,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      sig: null == sig
          ? _value.sig
          : sig // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Nip07Event with DiagnosticableTreeMixin implements _Nip07Event {
  const _$_Nip07Event(
      {required this.id,
      required this.pubkey,
      required this.created_at,
      required this.kind,
      required final List<List<String>> tags,
      required this.content,
      required this.sig})
      : _tags = tags;

  factory _$_Nip07Event.fromJson(Map<String, dynamic> json) =>
      _$$_Nip07EventFromJson(json);

  @override
  final String id;
// HEX
  @override
  final String pubkey;
//HEX
// ignore: non_constant_identifier_names
  @override
  final int created_at;
  @override
  final int kind;
  final List<List<String>> _tags;
  @override
  List<List<String>> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String content;
  @override
  final String sig;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Nip07Event(id: $id, pubkey: $pubkey, created_at: $created_at, kind: $kind, tags: $tags, content: $content, sig: $sig)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Nip07Event'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('pubkey', pubkey))
      ..add(DiagnosticsProperty('created_at', created_at))
      ..add(DiagnosticsProperty('kind', kind))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('sig', sig));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Nip07Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pubkey, pubkey) || other.pubkey == pubkey) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sig, sig) || other.sig == sig));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pubkey, created_at, kind,
      const DeepCollectionEquality().hash(_tags), content, sig);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_Nip07EventCopyWith<_$_Nip07Event> get copyWith =>
      __$$_Nip07EventCopyWithImpl<_$_Nip07Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_Nip07EventToJson(
      this,
    );
  }
}

abstract class _Nip07Event implements Nip07Event {
  const factory _Nip07Event(
      {required final String id,
      required final String pubkey,
      required final int created_at,
      required final int kind,
      required final List<List<String>> tags,
      required final String content,
      required final String sig}) = _$_Nip07Event;

  factory _Nip07Event.fromJson(Map<String, dynamic> json) =
      _$_Nip07Event.fromJson;

  @override
  String get id;
  @override // HEX
  String get pubkey;
  @override //HEX
// ignore: non_constant_identifier_names
  int get created_at;
  @override
  int get kind;
  @override
  List<List<String>> get tags;
  @override
  String get content;
  @override
  String get sig;
  @override
  @JsonKey(ignore: true)
  _$$_Nip07EventCopyWith<_$_Nip07Event> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TextNote {
// --- 生データ
  String get rawJson => throw _privateConstructorUsedError;
  List<String> get relays => throw _privateConstructorUsedError; // --- 基本情報
  String get id => throw _privateConstructorUsedError; // NIP-19
  String get pubkey => throw _privateConstructorUsedError; //NIP-19
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // --- TextNote基本情報
  String get content => throw _privateConstructorUsedError;
  List<List<String>> get tags =>
      throw _privateConstructorUsedError; // --- TextNote付属情報
  String? get nip36 => throw _privateConstructorUsedError;
  Metadata? get autherMetadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextNoteCopyWith<TextNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextNoteCopyWith<$Res> {
  factory $TextNoteCopyWith(TextNote value, $Res Function(TextNote) then) =
      _$TextNoteCopyWithImpl<$Res, TextNote>;
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String content,
      List<List<String>> tags,
      String? nip36,
      Metadata? autherMetadata});

  $MetadataCopyWith<$Res>? get autherMetadata;
}

/// @nodoc
class _$TextNoteCopyWithImpl<$Res, $Val extends TextNote>
    implements $TextNoteCopyWith<$Res> {
  _$TextNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? content = null,
    Object? tags = null,
    Object? nip36 = freezed,
    Object? autherMetadata = freezed,
  }) {
    return _then(_value.copyWith(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      nip36: freezed == nip36
          ? _value.nip36
          : nip36 // ignore: cast_nullable_to_non_nullable
              as String?,
      autherMetadata: freezed == autherMetadata
          ? _value.autherMetadata
          : autherMetadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res>? get autherMetadata {
    if (_value.autherMetadata == null) {
      return null;
    }

    return $MetadataCopyWith<$Res>(_value.autherMetadata!, (value) {
      return _then(_value.copyWith(autherMetadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TextNoteCopyWith<$Res> implements $TextNoteCopyWith<$Res> {
  factory _$$_TextNoteCopyWith(
          _$_TextNote value, $Res Function(_$_TextNote) then) =
      __$$_TextNoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String content,
      List<List<String>> tags,
      String? nip36,
      Metadata? autherMetadata});

  @override
  $MetadataCopyWith<$Res>? get autherMetadata;
}

/// @nodoc
class __$$_TextNoteCopyWithImpl<$Res>
    extends _$TextNoteCopyWithImpl<$Res, _$_TextNote>
    implements _$$_TextNoteCopyWith<$Res> {
  __$$_TextNoteCopyWithImpl(
      _$_TextNote _value, $Res Function(_$_TextNote) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? content = null,
    Object? tags = null,
    Object? nip36 = freezed,
    Object? autherMetadata = freezed,
  }) {
    return _then(_$_TextNote(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      nip36: freezed == nip36
          ? _value.nip36
          : nip36 // ignore: cast_nullable_to_non_nullable
              as String?,
      autherMetadata: freezed == autherMetadata
          ? _value.autherMetadata
          : autherMetadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
    ));
  }
}

/// @nodoc

class _$_TextNote with DiagnosticableTreeMixin implements _TextNote {
  const _$_TextNote(
      {required this.rawJson,
      required final List<String> relays,
      required this.id,
      required this.pubkey,
      required this.createdAt,
      required this.content,
      required final List<List<String>> tags,
      required this.nip36,
      required this.autherMetadata})
      : _relays = relays,
        _tags = tags;

// --- 生データ
  @override
  final String rawJson;
  final List<String> _relays;
  @override
  List<String> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

// --- 基本情報
  @override
  final String id;
// NIP-19
  @override
  final String pubkey;
//NIP-19
  @override
  final DateTime createdAt;
// --- TextNote基本情報
  @override
  final String content;
  final List<List<String>> _tags;
  @override
  List<List<String>> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

// --- TextNote付属情報
  @override
  final String? nip36;
  @override
  final Metadata? autherMetadata;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TextNote(rawJson: $rawJson, relays: $relays, id: $id, pubkey: $pubkey, createdAt: $createdAt, content: $content, tags: $tags, nip36: $nip36, autherMetadata: $autherMetadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TextNote'))
      ..add(DiagnosticsProperty('rawJson', rawJson))
      ..add(DiagnosticsProperty('relays', relays))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('pubkey', pubkey))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('nip36', nip36))
      ..add(DiagnosticsProperty('autherMetadata', autherMetadata));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextNote &&
            (identical(other.rawJson, rawJson) || other.rawJson == rawJson) &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pubkey, pubkey) || other.pubkey == pubkey) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.nip36, nip36) || other.nip36 == nip36) &&
            (identical(other.autherMetadata, autherMetadata) ||
                other.autherMetadata == autherMetadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      rawJson,
      const DeepCollectionEquality().hash(_relays),
      id,
      pubkey,
      createdAt,
      content,
      const DeepCollectionEquality().hash(_tags),
      nip36,
      autherMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TextNoteCopyWith<_$_TextNote> get copyWith =>
      __$$_TextNoteCopyWithImpl<_$_TextNote>(this, _$identity);
}

abstract class _TextNote implements TextNote {
  const factory _TextNote(
      {required final String rawJson,
      required final List<String> relays,
      required final String id,
      required final String pubkey,
      required final DateTime createdAt,
      required final String content,
      required final List<List<String>> tags,
      required final String? nip36,
      required final Metadata? autherMetadata}) = _$_TextNote;

  @override // --- 生データ
  String get rawJson;
  @override
  List<String> get relays;
  @override // --- 基本情報
  String get id;
  @override // NIP-19
  String get pubkey;
  @override //NIP-19
  DateTime get createdAt;
  @override // --- TextNote基本情報
  String get content;
  @override
  List<List<String>> get tags;
  @override // --- TextNote付属情報
  String? get nip36;
  @override
  Metadata? get autherMetadata;
  @override
  @JsonKey(ignore: true)
  _$$_TextNoteCopyWith<_$_TextNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Metadata {
// --- 生データ
  String get rawJson => throw _privateConstructorUsedError;
  List<String> get relays => throw _privateConstructorUsedError; // --- 基本情報
  String get id => throw _privateConstructorUsedError; // NIP-19
  String get pubkey => throw _privateConstructorUsedError; //NIP-19
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // --- Metadata情報(基本)
  String? get name => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError; // --- Metadata情報(応用)
  String? get banner => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get nip05 => throw _privateConstructorUsedError;
  String? get lud16 => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MetadataCopyWith<Metadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetadataCopyWith<$Res> {
  factory $MetadataCopyWith(Metadata value, $Res Function(Metadata) then) =
      _$MetadataCopyWithImpl<$Res, Metadata>;
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String? name,
      String? picture,
      String? about,
      String? banner,
      String? website,
      String? nip05,
      String? lud16,
      String? displayName});
}

/// @nodoc
class _$MetadataCopyWithImpl<$Res, $Val extends Metadata>
    implements $MetadataCopyWith<$Res> {
  _$MetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? name = freezed,
    Object? picture = freezed,
    Object? about = freezed,
    Object? banner = freezed,
    Object? website = freezed,
    Object? nip05 = freezed,
    Object? lud16 = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      nip05: freezed == nip05
          ? _value.nip05
          : nip05 // ignore: cast_nullable_to_non_nullable
              as String?,
      lud16: freezed == lud16
          ? _value.lud16
          : lud16 // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MetadataCopyWith<$Res> implements $MetadataCopyWith<$Res> {
  factory _$$_MetadataCopyWith(
          _$_Metadata value, $Res Function(_$_Metadata) then) =
      __$$_MetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String? name,
      String? picture,
      String? about,
      String? banner,
      String? website,
      String? nip05,
      String? lud16,
      String? displayName});
}

/// @nodoc
class __$$_MetadataCopyWithImpl<$Res>
    extends _$MetadataCopyWithImpl<$Res, _$_Metadata>
    implements _$$_MetadataCopyWith<$Res> {
  __$$_MetadataCopyWithImpl(
      _$_Metadata _value, $Res Function(_$_Metadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? name = freezed,
    Object? picture = freezed,
    Object? about = freezed,
    Object? banner = freezed,
    Object? website = freezed,
    Object? nip05 = freezed,
    Object? lud16 = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_$_Metadata(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      nip05: freezed == nip05
          ? _value.nip05
          : nip05 // ignore: cast_nullable_to_non_nullable
              as String?,
      lud16: freezed == lud16
          ? _value.lud16
          : lud16 // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Metadata with DiagnosticableTreeMixin implements _Metadata {
  const _$_Metadata(
      {required this.rawJson,
      required final List<String> relays,
      required this.id,
      required this.pubkey,
      required this.createdAt,
      required this.name,
      required this.picture,
      required this.about,
      required this.banner,
      required this.website,
      required this.nip05,
      required this.lud16,
      required this.displayName})
      : _relays = relays;

// --- 生データ
  @override
  final String rawJson;
  final List<String> _relays;
  @override
  List<String> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

// --- 基本情報
  @override
  final String id;
// NIP-19
  @override
  final String pubkey;
//NIP-19
  @override
  final DateTime createdAt;
// --- Metadata情報(基本)
  @override
  final String? name;
  @override
  final String? picture;
  @override
  final String? about;
// --- Metadata情報(応用)
  @override
  final String? banner;
  @override
  final String? website;
  @override
  final String? nip05;
  @override
  final String? lud16;
  @override
  final String? displayName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Metadata(rawJson: $rawJson, relays: $relays, id: $id, pubkey: $pubkey, createdAt: $createdAt, name: $name, picture: $picture, about: $about, banner: $banner, website: $website, nip05: $nip05, lud16: $lud16, displayName: $displayName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Metadata'))
      ..add(DiagnosticsProperty('rawJson', rawJson))
      ..add(DiagnosticsProperty('relays', relays))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('pubkey', pubkey))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('picture', picture))
      ..add(DiagnosticsProperty('about', about))
      ..add(DiagnosticsProperty('banner', banner))
      ..add(DiagnosticsProperty('website', website))
      ..add(DiagnosticsProperty('nip05', nip05))
      ..add(DiagnosticsProperty('lud16', lud16))
      ..add(DiagnosticsProperty('displayName', displayName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Metadata &&
            (identical(other.rawJson, rawJson) || other.rawJson == rawJson) &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pubkey, pubkey) || other.pubkey == pubkey) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.nip05, nip05) || other.nip05 == nip05) &&
            (identical(other.lud16, lud16) || other.lud16 == lud16) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      rawJson,
      const DeepCollectionEquality().hash(_relays),
      id,
      pubkey,
      createdAt,
      name,
      picture,
      about,
      banner,
      website,
      nip05,
      lud16,
      displayName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MetadataCopyWith<_$_Metadata> get copyWith =>
      __$$_MetadataCopyWithImpl<_$_Metadata>(this, _$identity);
}

abstract class _Metadata implements Metadata {
  const factory _Metadata(
      {required final String rawJson,
      required final List<String> relays,
      required final String id,
      required final String pubkey,
      required final DateTime createdAt,
      required final String? name,
      required final String? picture,
      required final String? about,
      required final String? banner,
      required final String? website,
      required final String? nip05,
      required final String? lud16,
      required final String? displayName}) = _$_Metadata;

  @override // --- 生データ
  String get rawJson;
  @override
  List<String> get relays;
  @override // --- 基本情報
  String get id;
  @override // NIP-19
  String get pubkey;
  @override //NIP-19
  DateTime get createdAt;
  @override // --- Metadata情報(基本)
  String? get name;
  @override
  String? get picture;
  @override
  String? get about;
  @override // --- Metadata情報(応用)
  String? get banner;
  @override
  String? get website;
  @override
  String? get nip05;
  @override
  String? get lud16;
  @override
  String? get displayName;
  @override
  @JsonKey(ignore: true)
  _$$_MetadataCopyWith<_$_Metadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Reaction {
// --- 生データ
  String get rawJson => throw _privateConstructorUsedError;
  List<String> get relays => throw _privateConstructorUsedError; // --- 基本情報
  String get id => throw _privateConstructorUsedError; // NIP-19
  String get pubkey => throw _privateConstructorUsedError; //NIP-19
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // --- Reaction情報
  String get content => throw _privateConstructorUsedError;
  String? get emojiUrl => throw _privateConstructorUsedError;
  String get targetId => throw _privateConstructorUsedError;
  String get targetPubkey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReactionCopyWith<Reaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReactionCopyWith<$Res> {
  factory $ReactionCopyWith(Reaction value, $Res Function(Reaction) then) =
      _$ReactionCopyWithImpl<$Res, Reaction>;
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String content,
      String? emojiUrl,
      String targetId,
      String targetPubkey});
}

/// @nodoc
class _$ReactionCopyWithImpl<$Res, $Val extends Reaction>
    implements $ReactionCopyWith<$Res> {
  _$ReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? content = null,
    Object? emojiUrl = freezed,
    Object? targetId = null,
    Object? targetPubkey = null,
  }) {
    return _then(_value.copyWith(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojiUrl: freezed == emojiUrl
          ? _value.emojiUrl
          : emojiUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      targetPubkey: null == targetPubkey
          ? _value.targetPubkey
          : targetPubkey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReactionCopyWith<$Res> implements $ReactionCopyWith<$Res> {
  factory _$$_ReactionCopyWith(
          _$_Reaction value, $Res Function(_$_Reaction) then) =
      __$$_ReactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String rawJson,
      List<String> relays,
      String id,
      String pubkey,
      DateTime createdAt,
      String content,
      String? emojiUrl,
      String targetId,
      String targetPubkey});
}

/// @nodoc
class __$$_ReactionCopyWithImpl<$Res>
    extends _$ReactionCopyWithImpl<$Res, _$_Reaction>
    implements _$$_ReactionCopyWith<$Res> {
  __$$_ReactionCopyWithImpl(
      _$_Reaction _value, $Res Function(_$_Reaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawJson = null,
    Object? relays = null,
    Object? id = null,
    Object? pubkey = null,
    Object? createdAt = null,
    Object? content = null,
    Object? emojiUrl = freezed,
    Object? targetId = null,
    Object? targetPubkey = null,
  }) {
    return _then(_$_Reaction(
      rawJson: null == rawJson
          ? _value.rawJson
          : rawJson // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pubkey: null == pubkey
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emojiUrl: freezed == emojiUrl
          ? _value.emojiUrl
          : emojiUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      targetPubkey: null == targetPubkey
          ? _value.targetPubkey
          : targetPubkey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Reaction with DiagnosticableTreeMixin implements _Reaction {
  const _$_Reaction(
      {required this.rawJson,
      required final List<String> relays,
      required this.id,
      required this.pubkey,
      required this.createdAt,
      required this.content,
      required this.emojiUrl,
      required this.targetId,
      required this.targetPubkey})
      : _relays = relays;

// --- 生データ
  @override
  final String rawJson;
  final List<String> _relays;
  @override
  List<String> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

// --- 基本情報
  @override
  final String id;
// NIP-19
  @override
  final String pubkey;
//NIP-19
  @override
  final DateTime createdAt;
// --- Reaction情報
  @override
  final String content;
  @override
  final String? emojiUrl;
  @override
  final String targetId;
  @override
  final String targetPubkey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Reaction(rawJson: $rawJson, relays: $relays, id: $id, pubkey: $pubkey, createdAt: $createdAt, content: $content, emojiUrl: $emojiUrl, targetId: $targetId, targetPubkey: $targetPubkey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Reaction'))
      ..add(DiagnosticsProperty('rawJson', rawJson))
      ..add(DiagnosticsProperty('relays', relays))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('pubkey', pubkey))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('emojiUrl', emojiUrl))
      ..add(DiagnosticsProperty('targetId', targetId))
      ..add(DiagnosticsProperty('targetPubkey', targetPubkey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reaction &&
            (identical(other.rawJson, rawJson) || other.rawJson == rawJson) &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pubkey, pubkey) || other.pubkey == pubkey) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.emojiUrl, emojiUrl) ||
                other.emojiUrl == emojiUrl) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.targetPubkey, targetPubkey) ||
                other.targetPubkey == targetPubkey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      rawJson,
      const DeepCollectionEquality().hash(_relays),
      id,
      pubkey,
      createdAt,
      content,
      emojiUrl,
      targetId,
      targetPubkey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReactionCopyWith<_$_Reaction> get copyWith =>
      __$$_ReactionCopyWithImpl<_$_Reaction>(this, _$identity);
}

abstract class _Reaction implements Reaction {
  const factory _Reaction(
      {required final String rawJson,
      required final List<String> relays,
      required final String id,
      required final String pubkey,
      required final DateTime createdAt,
      required final String content,
      required final String? emojiUrl,
      required final String targetId,
      required final String targetPubkey}) = _$_Reaction;

  @override // --- 生データ
  String get rawJson;
  @override
  List<String> get relays;
  @override // --- 基本情報
  String get id;
  @override // NIP-19
  String get pubkey;
  @override //NIP-19
  DateTime get createdAt;
  @override // --- Reaction情報
  String get content;
  @override
  String? get emojiUrl;
  @override
  String get targetId;
  @override
  String get targetPubkey;
  @override
  @JsonKey(ignore: true)
  _$$_ReactionCopyWith<_$_Reaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendServer {
  String get address => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;
  bool get write => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecommendServerCopyWith<RecommendServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendServerCopyWith<$Res> {
  factory $RecommendServerCopyWith(
          RecommendServer value, $Res Function(RecommendServer) then) =
      _$RecommendServerCopyWithImpl<$Res, RecommendServer>;
  @useResult
  $Res call({String address, bool read, bool write});
}

/// @nodoc
class _$RecommendServerCopyWithImpl<$Res, $Val extends RecommendServer>
    implements $RecommendServerCopyWith<$Res> {
  _$RecommendServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? read = null,
    Object? write = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      write: null == write
          ? _value.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecommendServerCopyWith<$Res>
    implements $RecommendServerCopyWith<$Res> {
  factory _$$_RecommendServerCopyWith(
          _$_RecommendServer value, $Res Function(_$_RecommendServer) then) =
      __$$_RecommendServerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, bool read, bool write});
}

/// @nodoc
class __$$_RecommendServerCopyWithImpl<$Res>
    extends _$RecommendServerCopyWithImpl<$Res, _$_RecommendServer>
    implements _$$_RecommendServerCopyWith<$Res> {
  __$$_RecommendServerCopyWithImpl(
      _$_RecommendServer _value, $Res Function(_$_RecommendServer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? read = null,
    Object? write = null,
  }) {
    return _then(_$_RecommendServer(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      write: null == write
          ? _value.write
          : write // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RecommendServer
    with DiagnosticableTreeMixin
    implements _RecommendServer {
  const _$_RecommendServer(
      {required this.address, required this.read, required this.write});

  @override
  final String address;
  @override
  final bool read;
  @override
  final bool write;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecommendServer(address: $address, read: $read, write: $write)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecommendServer'))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('read', read))
      ..add(DiagnosticsProperty('write', write));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecommendServer &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.write, write) || other.write == write));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, read, write);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecommendServerCopyWith<_$_RecommendServer> get copyWith =>
      __$$_RecommendServerCopyWithImpl<_$_RecommendServer>(this, _$identity);
}

abstract class _RecommendServer implements RecommendServer {
  const factory _RecommendServer(
      {required final String address,
      required final bool read,
      required final bool write}) = _$_RecommendServer;

  @override
  String get address;
  @override
  bool get read;
  @override
  bool get write;
  @override
  @JsonKey(ignore: true)
  _$$_RecommendServerCopyWith<_$_RecommendServer> get copyWith =>
      throw _privateConstructorUsedError;
}
