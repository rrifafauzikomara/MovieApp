import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';
import 'package:moviecatalogue/network/repository/repository.dart';

class LocalRepository implements Repository {
  @override
  Future<Result> getNowPlaying([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language, int page = 1]) {
    // TODO: implement getNowPlaying
    return null;
  }

  @override
  Future<Result> getPopular([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language, int page = 1]) {
    // TODO: implement getPopular
    return null;
  }

  @override
  Future<Result> getTopRated([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language, int page = 1]) {
    // TODO: implement getTopRated
    return null;
  }

  @override
  Future<Result> getUpComing([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language, int page = 1]) {
    // TODO: implement getUpComing
    return null;
  }

}