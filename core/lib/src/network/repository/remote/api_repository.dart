import 'package:dio/dio.dart';
import 'package:core/core.dart';

class ApiRepository implements Repository {
  Dio _dio;
  RestClient _restClient;

  ApiRepository() {
    _dio = Dio();
    _restClient = RestClient(_dio);
  }

  @override
  Future<Result> getMovieNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getMovieNowPlaying(apiKey, language);
  }

  @override
  Future<Result> getMovieUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getMovieUpComing(apiKey, language);
  }

  @override
  Future<Result> getMoviePopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getMoviePopular(apiKey, language);
  }

  @override
  Future<Result> getTvAiringToday(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getTvAiringToday(apiKey, language);
  }

  @override
  Future<Result> getTvPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getTvPopular(apiKey, language);
  }

  @override
  Future<Result> getTvOnTheAir(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    return _restClient.getTvOnTheAir(apiKey, language);
  }

  @override
  Future<ResultCrew> getMovieCrew([int movieId, String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    return _restClient.getMovieCrews(movieId, apiKey, language);
  }

  @override
  Future<ResultTrailer> getMovieTrailer(int movieId, [String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    return _restClient.getMovieTrailer(movieId, apiKey, language);
  }
}
