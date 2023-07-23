// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OPGMetaData {
  String get title => throw _privateConstructorUsedError;
  Uint8List? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OPGMetaDataCopyWith<OPGMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OPGMetaDataCopyWith<$Res> {
  factory $OPGMetaDataCopyWith(
          OPGMetaData value, $Res Function(OPGMetaData) then) =
      _$OPGMetaDataCopyWithImpl<$Res, OPGMetaData>;
  @useResult
  $Res call({String title, Uint8List? image});
}

/// @nodoc
class _$OPGMetaDataCopyWithImpl<$Res, $Val extends OPGMetaData>
    implements $OPGMetaDataCopyWith<$Res> {
  _$OPGMetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OPGMetaDataCopyWith<$Res>
    implements $OPGMetaDataCopyWith<$Res> {
  factory _$$_OPGMetaDataCopyWith(
          _$_OPGMetaData value, $Res Function(_$_OPGMetaData) then) =
      __$$_OPGMetaDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, Uint8List? image});
}

/// @nodoc
class __$$_OPGMetaDataCopyWithImpl<$Res>
    extends _$OPGMetaDataCopyWithImpl<$Res, _$_OPGMetaData>
    implements _$$_OPGMetaDataCopyWith<$Res> {
  __$$_OPGMetaDataCopyWithImpl(
      _$_OPGMetaData _value, $Res Function(_$_OPGMetaData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? image = freezed,
  }) {
    return _then(_$_OPGMetaData(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

class _$_OPGMetaData with DiagnosticableTreeMixin implements _OPGMetaData {
  const _$_OPGMetaData({required this.title, required this.image});

  @override
  final String title;
  @override
  final Uint8List? image;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OPGMetaData(title: $title, image: $image)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OPGMetaData'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('image', image));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OPGMetaData &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.image, image));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(image));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OPGMetaDataCopyWith<_$_OPGMetaData> get copyWith =>
      __$$_OPGMetaDataCopyWithImpl<_$_OPGMetaData>(this, _$identity);
}

abstract class _OPGMetaData implements OPGMetaData {
  const factory _OPGMetaData(
      {required final String title,
      required final Uint8List? image}) = _$_OPGMetaData;

  @override
  String get title;
  @override
  Uint8List? get image;
  @override
  @JsonKey(ignore: true)
  _$$_OPGMetaDataCopyWith<_$_OPGMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}
