import 'package:core/core.dart';
import 'package:core/src/network/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class ApiRepository implements Repository {
  final ApiService apiService;

  ApiRepository({@required this.apiService});

  @override
  Future<Result> getMovieNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getMovieNowPlaying(apiKey, language);
  }

  @override
  Future<Result> getMovieUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getMovieUpComing(apiKey, language);
  }

  @override
  Future<Result> getMoviePopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getMoviePopular(apiKey, language);
  }

  @override
  Future<Result> getTvAiringToday(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getTvAiringToday(apiKey, language);
  }

  @override
  Future<Result> getTvPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getTvPopular(apiKey, language);
  }

  @override
  Future<Result> getTvOnTheAir(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getTvOnTheAir(apiKey, language);
  }

  @override
  Future<ResultCrew> getMovieCrew(
      [int movieId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return apiService.getMovieCrews(movieId, apiKey, language);
  }

  @override
  Future<ResultTrailer> getMovieTrailer(int movieId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return apiService.getMovieTrailer(movieId, apiKey, language);
  }

  @override
  Future<ResultCrew> getTvShowCrew(
      [int tvId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return apiService.getTvShowCrews(tvId, apiKey, language);
  }

  @override
  Future<ResultTrailer> getTvShowTrailer(int tvId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return apiService.getTvShowTrailer(tvId, apiKey, language);
  }

  @override
  Future<Result> getDiscoverMovie(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return apiService.getDiscoverMovie(apiKey, language);
  }
}
