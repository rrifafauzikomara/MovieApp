import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final Dio dio;

  ApiService({@required this.dio});

  Future<Result> getMovieNowPlaying(String apiKey, String language) async {
    try {
      final response = await dio.get("movie/now_playing",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getMovieUpComing(String apiKey, String language) async {
    try {
      final response = await dio.get("movie/upcoming",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getMoviePopular(String apiKey, String language) async {
    try {
      final response = await dio.get("movie/popular",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getDiscoverMovie(String apiKey, String language) async {
    try {
      final response = await dio.get("discover/movie",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getTvAiringToday(String apiKey, String language) async {
    try {
      final response = await dio.get("tv/airing_today",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getTvPopular(String apiKey, String language) async {
    try {
      final response = await dio.get("tv/popular",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<Result> getTvOnTheAir(String apiKey, String language) async {
    try {
      final response = await dio.get("tv/on_the_air",
          queryParameters: {"api_key": apiKey, "language": language});
      return Result.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<ResultCrew> getMovieCrews(
      int movieId, String apiKey, String language) async {
    try {
      final response = await dio
          .get("movie/$movieId/credits?api_key=$apiKey&language=$language");
      return ResultCrew.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<ResultTrailer> getMovieTrailer(
      int movieId, String apiKey, String language) async {
    try {
      final response = await dio
          .get("movie/$movieId/videos?api_key=$apiKey&language=$language");
      return ResultTrailer.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<ResultCrew> getTvShowCrews(
      int tvId, String apiKey, String language) async {
    try {
      final response =
          await dio.get("tv/$tvId/credits?api_key=$apiKey&language=$language");
      return ResultCrew.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  Future<ResultTrailer> getTvShowTrailer(
      int tvId, String apiKey, String language) async {
    try {
      final response =
          await dio.get("tv/$tvId/videos?api_key=$apiKey&language=$language");
      return ResultTrailer.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}
