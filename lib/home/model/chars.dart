import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marval/home/model/thumbnail.dart';

part 'chars.freezed.dart';
part 'chars.g.dart';

@freezed
class Chars with _$Chars {
  factory Chars({
    required int id,
    required String name,
    required Thumbnail thumbnail,
    required String modified,
    required String description
  }) = _Chars;
	
  factory Chars.fromJson(Map<String, dynamic> json) => _$CharsFromJson(json);
}

