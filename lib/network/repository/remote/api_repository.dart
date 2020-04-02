import 'package:dio/dio.dart';
import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';
import 'package:moviecatalogue/network/repository/repository.dart';

class ApiRepository implements Repository {

  Dio _dio;
  RestClient _restClient;

  ApiRepository() {
    _dio = Dio();
    _restClient = RestClient(_dio);
  }

  @override
  Future<Result> getNowPlaying([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    return _restClient.getNowPlaying(apiKey, language);
  }

  @override
  Future<Result> getPopular([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    return _restClient.getPopular(apiKey, language);
  }

  @override
  Future<Result> getTopRated([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    return _restClient.getTopRated(apiKey, language);
  }

  @override
  Future<Result> getUpComing([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) {
    return _restClient.getUpComing(apiKey, language);
  }

}