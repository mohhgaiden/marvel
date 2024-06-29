import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marval/home/model/thumbnail.dart';
part 'comics.freezed.dart';
part 'comics.g.dart';

@freezed
class Comics with _$Comics {
  factory Comics(
    int id,
    String title,
    Thumbnail thumbnail,
    String? description,
  ) = _Comics;
	
  factory Comics.fromJson(Map<String, dynamic> json) => _$ComicsFromJson(json);
}
