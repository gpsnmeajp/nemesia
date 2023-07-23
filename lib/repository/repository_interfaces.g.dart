// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_interfaces.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Nip07Event _$$_Nip07EventFromJson(Map<String, dynamic> json) =>
    _$_Nip07Event(
      id: json['id'] as String,
      pubkey: json['pubkey'] as String,
      created_at: json['created_at'] as int,
      kind: json['kind'] as int,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
      content: json['content'] as String,
      sig: json['sig'] as String,
    );

Map<String, dynamic> _$$_Nip07EventToJson(_$_Nip07Event instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pubkey': instance.pubkey,
      'created_at': instance.created_at,
      'kind': instance.kind,
      'tags': instance.tags,
      'content': instance.content,
      'sig': instance.sig,
    };
