import 'package:marval/bookmark/model/bookmark.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BookMarksDatabase {
  BookMarksDatabase._privateConstructor();

  static final BookMarksDatabase instance =
      BookMarksDatabase._privateConstructor();
  static Database? _database;

  final String tableBookmark = 'Bookmark';
  final String idCol = 'id';
  final String nameCol = 'name';
  final String imageCol = 'image';
  final dbName = 'takobookmarks.db';
  final idType = 'TEXT NOT NULL';
  final textType = 'TEXT NOT NULL';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database db, version) async {
    await db.execute('''
    CREATE TABLE $tableBookmark(
      $idCol $idType, $nameCol $textType, $imageCol $textType)''');
  }

  Future<void> insert(Bookmark bookMark) async {
    final db = await instance.database;
    final result = await db.insert(tableBookmark, bookMark.toJson());
    if (result != -1) {
      // ignore: avoid_print
      print('success');
    }
  }

  Future<List<Bookmark>>? getAllBookMarks() async {
    final db = await instance.database;
    final results = await db.query(tableBookmark);
    return results.map((json) => Bookmark.fromJson(json)).toList();
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return db.delete(
      tableBookmark,
      where: '$idCol == ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}