import 'package:prosample_1/User/Favorites/db/model.dart';
import 'package:sqflite/sqflite.dart';

late Database data;
List <Map<String,dynamic>> favorites = [];
class DatabaseHelper {
  DatabaseHelper._privateConstructor(); // Private constructor for singleton pattern
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _dbName = 'favorite.db';
  static const _dbVersion = 1;

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_dbName';

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE favorite (id TEXT PRIMARY KEY, name TEXT, oldprice INTEGER, newprice INTEGER, image TEXT, fav BOOLEAN)',
        );
      },
    );
  }

  Future<void> insertFav(FavModel fav) async {
    final db = await database;
    final map = <String, dynamic>{
      'id': fav.id,
      'image': fav.image,
      'name': fav.name,
      'oldprice': fav.oldPrice,
      'newprice': fav.newPrice,
      'fav': fav.fav,
    };
    print(map);
    await db.insert('favorite', map);
  }

  Future<List<FavModel>> getFavs() async {
    final db = await database;
    final maps = await db.query('favorite');
    favorites = maps;
    return List.generate(maps.length, (i) => FavModel.toMap(maps[i]));
  }

  Future<void> deleteFav(String id) async {
    final db = await database;
    await db.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<bool> isFavorited(String id) async {
    final db = await database;
    final maps = await db.query(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}




