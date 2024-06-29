// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharsImpl _$$CharsImplFromJson(Map<String, dynamic> json) => _$CharsImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      thumbnail: Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      modified: json['modified'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$CharsImplToJson(_$CharsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'modified': instance.modified,
      'description': instance.description,
    };
