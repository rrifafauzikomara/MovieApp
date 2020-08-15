import 'package:core/core.dart';

abstract class Repository {
  Future<Result> getMovieNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getMovieUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getMoviePopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getTvAiringToday(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getTvPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getTvOnTheAir(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<ResultCrew> getMovieCrew(
      [int movieId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<ResultTrailer> getMovieTrailer(int movieId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<ResultCrew> getTvShowCrew(
      [int tvId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<ResultTrailer> getTvShowTrailer(int tvId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]);

  Future<Result> getDiscoverMovie(
      [String apiKey = ApiConstant.apiKey,
        String language = ApiConstant.language]);
}
