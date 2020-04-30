import '../network.dart';

abstract class Repository {
  Future<Result> getNowPlaying([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language
  ]);

  Future<Result> getUpComing([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language
  ]);

  Future<Result> getPopular([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language
  ]);

  Future<Result> getTopRated([
    String apiKey = ApiConstant.apiKey,
    String language = ApiConstant.language
  ]);
}
