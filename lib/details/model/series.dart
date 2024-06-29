import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:marval/home/model/thumbnail.dart';

part 'series.freezed.dart';
part 'series.g.dart';

@freezed
class Series with _$Series {
  factory Series(
    int id,
    String title,
    Thumbnail thumbnail,
    String? description,
  ) = _Series;
	
  factory Series.fromJson(Map<String, dynamic> json) =>	_$SeriesFromJson(json);
}
