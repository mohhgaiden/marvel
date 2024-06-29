// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ComicsImpl _$$ComicsImplFromJson(Map<String, dynamic> json) => _$ComicsImpl(
      (json['id'] as num).toInt(),
      json['title'] as String,
      Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      json['description'] as String?,
    );

Map<String, dynamic> _$$ComicsImplToJson(_$ComicsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
    };
