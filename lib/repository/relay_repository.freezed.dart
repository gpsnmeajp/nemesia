// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relay_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Subscription {
  String get id => throw _privateConstructorUsedError;
  Filter get filter => throw _privateConstructorUsedError;
  dynamic Function(String) get eoseCallback =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
          Subscription value, $Res Function(Subscription) then) =
      _$SubscriptionCopyWithImpl<$Res, Subscription>;
  @useResult
  $Res call({String id, Filter filter, dynamic Function(String) eoseCallback});
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filter = null,
    Object? eoseCallback = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter,
      eoseCallback: null == eoseCallback
          ? _value.eoseCallback
          : eoseCallback // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubscriptionCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$$_SubscriptionCopyWith(
          _$_Subscription value, $Res Function(_$_Subscription) then) =
      __$$_SubscriptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Filter filter, dynamic Function(String) eoseCallback});
}

/// @nodoc
class __$$_SubscriptionCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$_Subscription>
    implements _$$_SubscriptionCopyWith<$Res> {
  __$$_SubscriptionCopyWithImpl(
      _$_Subscription _value, $Res Function(_$_Subscription) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filter = null,
    Object? eoseCallback = null,
  }) {
    return _then(_$_Subscription(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as Filter,
      eoseCallback: null == eoseCallback
          ? _value.eoseCallback
          : eoseCallback // ignore: cast_nullable_to_non_nullable
              as dynamic Function(String),
    ));
  }
}

/// @nodoc

class _$_Subscription with DiagnosticableTreeMixin implements _Subscription {
  const _$_Subscription(
      {required this.id, required this.filter, required this.eoseCallback});

  @override
  final String id;
  @override
  final Filter filter;
  @override
  final dynamic Function(String) eoseCallback;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Subscription(id: $id, filter: $filter, eoseCallback: $eoseCallback)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Subscription'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('filter', filter))
      ..add(DiagnosticsProperty('eoseCallback', eoseCallback));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Subscription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.eoseCallback, eoseCallback) ||
                other.eoseCallback == eoseCallback));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, filter, eoseCallback);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubscriptionCopyWith<_$_Subscription> get copyWith =>
      __$$_SubscriptionCopyWithImpl<_$_Subscription>(this, _$identity);
}

abstract class _Subscription implements Subscription {
  const factory _Subscription(
      {required final String id,
      required final Filter filter,
      required final dynamic Function(String) eoseCallback}) = _$_Subscription;

  @override
  String get id;
  @override
  Filter get filter;
  @override
  dynamic Function(String) get eoseCallback;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionCopyWith<_$_Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventWithJson {
  Event get event => throw _privateConstructorUsedError;
  String get json => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventWithJsonCopyWith<EventWithJson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventWithJsonCopyWith<$Res> {
  factory $EventWithJsonCopyWith(
          EventWithJson value, $Res Function(EventWithJson) then) =
      _$EventWithJsonCopyWithImpl<$Res, EventWithJson>;
  @useResult
  $Res call({Event event, String json});
}

/// @nodoc
class _$EventWithJsonCopyWithImpl<$Res, $Val extends EventWithJson>
    implements $EventWithJsonCopyWith<$Res> {
  _$EventWithJsonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? json = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event,
      json: null == json
          ? _value.json
          : json // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventWithJsonCopyWith<$Res>
    implements $EventWithJsonCopyWith<$Res> {
  factory _$$_EventWithJsonCopyWith(
          _$_EventWithJson value, $Res Function(_$_EventWithJson) then) =
      __$$_EventWithJsonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Event event, String json});
}

/// @nodoc
class __$$_EventWithJsonCopyWithImpl<$Res>
    extends _$EventWithJsonCopyWithImpl<$Res, _$_EventWithJson>
    implements _$$_EventWithJsonCopyWith<$Res> {
  __$$_EventWithJsonCopyWithImpl(
      _$_EventWithJson _value, $Res Function(_$_EventWithJson) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? json = null,
  }) {
    return _then(_$_EventWithJson(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event,
      json: null == json
          ? _value.json
          : json // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EventWithJson with DiagnosticableTreeMixin implements _EventWithJson {
  const _$_EventWithJson({required this.event, required this.json});

  @override
  final Event event;
  @override
  final String json;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EventWithJson(event: $event, json: $json)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EventWithJson'))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('json', json));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventWithJson &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.json, json) || other.json == json));
  }

  @override
  int get hashCode => Object.hash(runtimeType, event, json);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventWithJsonCopyWith<_$_EventWithJson> get copyWith =>
      __$$_EventWithJsonCopyWithImpl<_$_EventWithJson>(this, _$identity);
}

abstract class _EventWithJson implements EventWithJson {
  const factory _EventWithJson(
      {required final Event event,
      required final String json}) = _$_EventWithJson;

  @override
  Event get event;
  @override
  String get json;
  @override
  @JsonKey(ignore: true)
  _$$_EventWithJsonCopyWith<_$_EventWithJson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReceivingEvents {
  Map<String, Map<String, EventWithJson>> get eventsOnRelays =>
      throw _privateConstructorUsedError;
  set eventsOnRelays(Map<String, Map<String, EventWithJson>> value) =>
      throw _privateConstructorUsedError;
  DateTime get lastReceived => throw _privateConstructorUsedError;
  set lastReceived(DateTime value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceivingEventsCopyWith<ReceivingEvents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivingEventsCopyWith<$Res> {
  factory $ReceivingEventsCopyWith(
          ReceivingEvents value, $Res Function(ReceivingEvents) then) =
      _$ReceivingEventsCopyWithImpl<$Res, ReceivingEvents>;
  @useResult
  $Res call(
      {Map<String, Map<String, EventWithJson>> eventsOnRelays,
      DateTime lastReceived});
}

/// @nodoc
class _$ReceivingEventsCopyWithImpl<$Res, $Val extends ReceivingEvents>
    implements $ReceivingEventsCopyWith<$Res> {
  _$ReceivingEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventsOnRelays = null,
    Object? lastReceived = null,
  }) {
    return _then(_value.copyWith(
      eventsOnRelays: null == eventsOnRelays
          ? _value.eventsOnRelays
          : eventsOnRelays // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, EventWithJson>>,
      lastReceived: null == lastReceived
          ? _value.lastReceived
          : lastReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceivingEventsCopyWith<$Res>
    implements $ReceivingEventsCopyWith<$Res> {
  factory _$$_ReceivingEventsCopyWith(
          _$_ReceivingEvents value, $Res Function(_$_ReceivingEvents) then) =
      __$$_ReceivingEventsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Map<String, EventWithJson>> eventsOnRelays,
      DateTime lastReceived});
}

/// @nodoc
class __$$_ReceivingEventsCopyWithImpl<$Res>
    extends _$ReceivingEventsCopyWithImpl<$Res, _$_ReceivingEvents>
    implements _$$_ReceivingEventsCopyWith<$Res> {
  __$$_ReceivingEventsCopyWithImpl(
      _$_ReceivingEvents _value, $Res Function(_$_ReceivingEvents) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventsOnRelays = null,
    Object? lastReceived = null,
  }) {
    return _then(_$_ReceivingEvents(
      eventsOnRelays: null == eventsOnRelays
          ? _value.eventsOnRelays
          : eventsOnRelays // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, EventWithJson>>,
      lastReceived: null == lastReceived
          ? _value.lastReceived
          : lastReceived // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_ReceivingEvents
    with DiagnosticableTreeMixin
    implements _ReceivingEvents {
  _$_ReceivingEvents(
      {required this.eventsOnRelays, required this.lastReceived});

  @override
  Map<String, Map<String, EventWithJson>> eventsOnRelays;
  @override
  DateTime lastReceived;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ReceivingEvents(eventsOnRelays: $eventsOnRelays, lastReceived: $lastReceived)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ReceivingEvents'))
      ..add(DiagnosticsProperty('eventsOnRelays', eventsOnRelays))
      ..add(DiagnosticsProperty('lastReceived', lastReceived));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceivingEventsCopyWith<_$_ReceivingEvents> get copyWith =>
      __$$_ReceivingEventsCopyWithImpl<_$_ReceivingEvents>(this, _$identity);
}

abstract class _ReceivingEvents implements ReceivingEvents {
  factory _ReceivingEvents(
      {required Map<String, Map<String, EventWithJson>> eventsOnRelays,
      required DateTime lastReceived}) = _$_ReceivingEvents;

  @override
  Map<String, Map<String, EventWithJson>> get eventsOnRelays;
  set eventsOnRelays(Map<String, Map<String, EventWithJson>> value);
  @override
  DateTime get lastReceived;
  set lastReceived(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$_ReceivingEventsCopyWith<_$_ReceivingEvents> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EventWithRelays {
  EventWithJson get event => throw _privateConstructorUsedError;
  List<String> get relays => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EventWithRelaysCopyWith<EventWithRelays> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventWithRelaysCopyWith<$Res> {
  factory $EventWithRelaysCopyWith(
          EventWithRelays value, $Res Function(EventWithRelays) then) =
      _$EventWithRelaysCopyWithImpl<$Res, EventWithRelays>;
  @useResult
  $Res call({EventWithJson event, List<String> relays});

  $EventWithJsonCopyWith<$Res> get event;
}

/// @nodoc
class _$EventWithRelaysCopyWithImpl<$Res, $Val extends EventWithRelays>
    implements $EventWithRelaysCopyWith<$Res> {
  _$EventWithRelaysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? relays = null,
  }) {
    return _then(_value.copyWith(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventWithJson,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventWithJsonCopyWith<$Res> get event {
    return $EventWithJsonCopyWith<$Res>(_value.event, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventWithRelaysCopyWith<$Res>
    implements $EventWithRelaysCopyWith<$Res> {
  factory _$$_EventWithRelaysCopyWith(
          _$_EventWithRelays value, $Res Function(_$_EventWithRelays) then) =
      __$$_EventWithRelaysCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EventWithJson event, List<String> relays});

  @override
  $EventWithJsonCopyWith<$Res> get event;
}

/// @nodoc
class __$$_EventWithRelaysCopyWithImpl<$Res>
    extends _$EventWithRelaysCopyWithImpl<$Res, _$_EventWithRelays>
    implements _$$_EventWithRelaysCopyWith<$Res> {
  __$$_EventWithRelaysCopyWithImpl(
      _$_EventWithRelays _value, $Res Function(_$_EventWithRelays) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? relays = null,
  }) {
    return _then(_$_EventWithRelays(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventWithJson,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_EventWithRelays
    with DiagnosticableTreeMixin
    implements _EventWithRelays {
  const _$_EventWithRelays({required this.event, required this.relays});

  @override
  final EventWithJson event;
  @override
  final List<String> relays;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EventWithRelays(event: $event, relays: $relays)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EventWithRelays'))
      ..add(DiagnosticsProperty('event', event))
      ..add(DiagnosticsProperty('relays', relays));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventWithRelays &&
            (identical(other.event, event) || other.event == event) &&
            const DeepCollectionEquality().equals(other.relays, relays));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, event, const DeepCollectionEquality().hash(relays));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventWithRelaysCopyWith<_$_EventWithRelays> get copyWith =>
      __$$_EventWithRelaysCopyWithImpl<_$_EventWithRelays>(this, _$identity);
}

abstract class _EventWithRelays implements EventWithRelays {
  const factory _EventWithRelays(
      {required final EventWithJson event,
      required final List<String> relays}) = _$_EventWithRelays;

  @override
  EventWithJson get event;
  @override
  List<String> get relays;
  @override
  @JsonKey(ignore: true)
  _$$_EventWithRelaysCopyWith<_$_EventWithRelays> get copyWith =>
      throw _privateConstructorUsedError;
}
