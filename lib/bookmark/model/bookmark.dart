
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
class Bookmark with _$Bookmark {
  factory Bookmark(
    String id,
    String name,
    String image,
  ) = _Bookmark;
	
  factory Bookmark.fromJson(Map<String, dynamic> json) =>
			_$BookmarkFromJson(json);
}
