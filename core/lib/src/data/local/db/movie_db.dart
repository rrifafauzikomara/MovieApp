import 'package:core/core.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MoviesDb {
  MoviesDb._();

  static final MoviesDb db = MoviesDb._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'movies.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating movies table");

        await database.execute(
          "CREATE TABLE favorite ("
          "id INTEGER PRIMARY KEY,"
          "idMovies INTEGER,"
          "title TEXT,"
          "overview TEXT,"
          "release_date TEXT,"
          "genre_ids TEXT,"
          "vote_average TEXT,"
          "popularity TEXT,"
          "poster_path TEXT,"
          "backdrop_path TEXT"
          ")",
        );
      },
    );
  }

  Future<List<Movies>> getFavoriteMovies() async {
    final db = await database;
    var res = await db.query("favorite", columns: [
      "id",
      "idMovies",
      "title",
      "overview",
      "release_date",
      "genre_ids",
      "vote_average",
      "popularity",
      "poster_path",
      "backdrop_path"
    ]);
    var moviesList = List<Movies>();
    res.forEach((currentMovies) {
      Movies movies = Movies.fromJson(currentMovies);
      moviesList.add(movies);
    });
    return moviesList;
  }

  Future<int> addFavoriteMovies(Movies movies) async {
    final db = await database;
    var res = await db.insert("favorite", movies.toJson());
    return res;
  }

  getFavoriteMoviesById(int idMovies) async {
    final db = await database;
    var res = await db
        .query("favorite", where: "idMovies = ?", whereArgs: [idMovies]);
    return res.isEmpty ? null : Movies.fromJson(res.first);
  }

  Future<int> deleteFavoriteMoviesById(int idMovies) async {
    final db = await database;
    var res = await db
        .delete("favorite", where: "idMovies = ?", whereArgs: [idMovies]);
    return res;
  }
}
