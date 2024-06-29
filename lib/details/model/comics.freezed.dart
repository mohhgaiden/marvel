// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comics _$ComicsFromJson(Map<String, dynamic> json) {
  return _Comics.fromJson(json);
}

/// @nodoc
mixin _$Comics {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  Thumbnail get thumbnail => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ComicsCopyWith<Comics> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComicsCopyWith<$Res> {
  factory $ComicsCopyWith(Comics value, $Res Function(Comics) then) =
      _$ComicsCopyWithImpl<$Res, Comics>;
  @useResult
  $Res call({int id, String title, Thumbnail thumbnail, String? description});

  $ThumbnailCopyWith<$Res> get thumbnail;
}

/// @nodoc
class _$ComicsCopyWithImpl<$Res, $Val extends Comics>
    implements $ComicsCopyWith<$Res> {
  _$ComicsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ThumbnailCopyWith<$Res> get thumbnail {
    return $ThumbnailCopyWith<$Res>(_value.thumbnail, (value) {
      return _then(_value.copyWith(thumbnail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ComicsImplCopyWith<$Res> implements $ComicsCopyWith<$Res> {
  factory _$$ComicsImplCopyWith(
          _$ComicsImpl value, $Res Function(_$ComicsImpl) then) =
      __$$ComicsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, Thumbnail thumbnail, String? description});

  @override
  $ThumbnailCopyWith<$Res> get thumbnail;
}

/// @nodoc
class __$$ComicsImplCopyWithImpl<$Res>
    extends _$ComicsCopyWithImpl<$Res, _$ComicsImpl>
    implements _$$ComicsImplCopyWith<$Res> {
  __$$ComicsImplCopyWithImpl(
      _$ComicsImpl _value, $Res Function(_$ComicsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? description = freezed,
  }) {
    return _then(_$ComicsImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ComicsImpl implements _Comics {
  _$ComicsImpl(this.id, this.title, this.thumbnail, this.description);

  factory _$ComicsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ComicsImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final Thumbnail thumbnail;
  @override
  final String? description;

  @override
  String toString() {
    return 'Comics(id: $id, title: $title, thumbnail: $thumbnail, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ComicsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, thumbnail, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ComicsImplCopyWith<_$ComicsImpl> get copyWith =>
      __$$ComicsImplCopyWithImpl<_$ComicsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ComicsImplToJson(
      this,
    );
  }
}

abstract class _Comics implements Comics {
  factory _Comics(final int id, final String title, final Thumbnail thumbnail,
      final String? description) = _$ComicsImpl;

  factory _Comics.fromJson(Map<String, dynamic> json) = _$ComicsImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  Thumbnail get thumbnail;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$ComicsImplCopyWith<_$ComicsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
