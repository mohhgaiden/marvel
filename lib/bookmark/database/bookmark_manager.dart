import 'package:get/get.dart';
import 'package:marval/bookmark/model/bookmark.dart';
import 'bookmark_database.dart';

class BookMarkManager extends GetxController {

  List<Bookmark> _list = [];
  List<String> _idList = [];

  List<Bookmark> get bookMarks => [..._list];
  List<String> get ids => [..._idList];

  Future<void> loadBookMarksFromDatabase() async {
    final dataList = await BookMarksDatabase.instance.getAllBookMarks();
    if (dataList != null) {
      _list = dataList;
      for (var bookMark in _list) {
        _idList.add(bookMark.id);
      }
    } else {
      _list = [];
      _idList = [];
    }
  }

  /// Creates a new bookmark
  void addToBookMarks(Bookmark item) {
    _list.add(item);
    _idList.add(item.id);
    BookMarksDatabase.instance.insert(item);
    update();
  }

  /// Removes an existing bookmark
  void removeFromBookMarks(Bookmark item) {
    _list.removeWhere((element) => element.id == item.id);
    _idList.remove(item.id);
    BookMarksDatabase.instance.delete(item.id);
    update();
  }
}