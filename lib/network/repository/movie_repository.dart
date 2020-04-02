import 'package:flutter/cupertino.dart';
import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';
import 'package:moviecatalogue/network/repository/local/local_repository.dart';
import 'package:moviecatalogue/network/repository/remote/api_repository.dart';
import 'package:moviecatalogue/network/repository/repository.dart';

class MovieRepository implements Repository {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;

  static final MovieRepository _singleton = MovieRepository._internal(
      apiRepository: ApiRepository(), localRepository: LocalRepository());

  factory MovieRepository() {
    return _singleton;
  }

  MovieRepository._internal(
      {@required this.apiRepository, @required this.localRepository});

  @override
  Future<Result> getNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return await apiRepository.getNowPlaying(apiKey, language);
  }

  @override
  Future<Result> getPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return await apiRepository.getPopular(apiKey, language);
  }

  @override
  Future<Result> getTopRated(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return await apiRepository.getTopRated(apiKey, language);
  }

  @override
  Future<Result> getUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    return await apiRepository.getUpComing(apiKey, language);
  }
}
