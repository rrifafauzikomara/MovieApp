import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';

abstract class Repository {
  Future<Result> getNowPlaying([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language,
    int page = 1,
  ]);

  Future<Result> getUpComing([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language,
    int page = 1,
  ]);

  Future<Result> getPopular([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language,
    int page = 1,
  ]);

  Future<Result> getTopRated([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language,
    int page = 1,
  ]);
}
