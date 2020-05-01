import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  final String _idMovies = "idMovies";

  saveToFavorite(int idMovies) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_idMovies, idMovies);
  }

  Future<int> getFavorite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idMovies = preferences.getInt(_idMovies);
    return idMovies;
  }

  deleteFromFavorite() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(_idMovies, null);
  }

}