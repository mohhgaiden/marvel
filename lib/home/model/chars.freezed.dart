// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chars.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chars _$CharsFromJson(Map<String, dynamic> json) {
  return _Chars.fromJson(json);
}

/// @nodoc
mixin _$Chars {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Thumbnail get thumbnail => throw _privateConstructorUsedError;
  String get modified => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharsCopyWith<Chars> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharsCopyWith<$Res> {
  factory $CharsCopyWith(Chars value, $Res Function(Chars) then) =
      _$CharsCopyWithImpl<$Res, Chars>;
  @useResult
  $Res call(
      {int id,
      String name,
      Thumbnail thumbnail,
      String modified,
      String description});

  $ThumbnailCopyWith<$Res> get thumbnail;
}

/// @nodoc
class _$CharsCopyWithImpl<$Res, $Val extends Chars>
    implements $CharsCopyWith<$Res> {
  _$CharsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnail = null,
    Object? modified = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$CharsImplCopyWith<$Res> implements $CharsCopyWith<$Res> {
  factory _$$CharsImplCopyWith(
          _$CharsImpl value, $Res Function(_$CharsImpl) then) =
      __$$CharsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      Thumbnail thumbnail,
      String modified,
      String description});

  @override
  $ThumbnailCopyWith<$Res> get thumbnail;
}

/// @nodoc
class __$$CharsImplCopyWithImpl<$Res>
    extends _$CharsCopyWithImpl<$Res, _$CharsImpl>
    implements _$$CharsImplCopyWith<$Res> {
  __$$CharsImplCopyWithImpl(
      _$CharsImpl _value, $Res Function(_$CharsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? thumbnail = null,
    Object? modified = null,
    Object? description = null,
  }) {
    return _then(_$CharsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as Thumbnail,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharsImpl implements _Chars {
  _$CharsImpl(
      {required this.id,
      required this.name,
      required this.thumbnail,
      required this.modified,
      required this.description});

  factory _$CharsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharsImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final Thumbnail thumbnail;
  @override
  final String modified;
  @override
  final String description;

  @override
  String toString() {
    return 'Chars(id: $id, name: $name, thumbnail: $thumbnail, modified: $modified, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.modified, modified) ||
                other.modified == modified) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, thumbnail, modified, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharsImplCopyWith<_$CharsImpl> get copyWith =>
      __$$CharsImplCopyWithImpl<_$CharsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharsImplToJson(
      this,
    );
  }
}

abstract class _Chars implements Chars {
  factory _Chars(
      {required final int id,
      required final String name,
      required final Thumbnail thumbnail,
      required final String modified,
      required final String description}) = _$CharsImpl;

  factory _Chars.fromJson(Map<String, dynamic> json) = _$CharsImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  Thumbnail get thumbnail;
  @override
  String get modified;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$CharsImplCopyWith<_$CharsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
