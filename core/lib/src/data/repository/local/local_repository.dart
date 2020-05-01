import 'dart:convert';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

class LocalRepository implements Repository {
  @override
  Future<Result> getNowPlaying([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await PrefHelper.getCache(AppConstant.NOW_PLAYING);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getPopular([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await PrefHelper.getCache(AppConstant.POPULAR);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getTopRated([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await PrefHelper.getCache(AppConstant.TOP_RATED);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getUpComing([String apiKey = ApiConstant.apiKey, String language = ApiConstant.language]) async {
    var fromCache = await PrefHelper.getCache(AppConstant.UP_COMING);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveNowPlaying(Result result) {
    return PrefHelper.storeCache(AppConstant.NOW_PLAYING, jsonEncode(result));
  }

  Future<bool> savePopular(Result result) {
    return PrefHelper.storeCache(AppConstant.POPULAR, jsonEncode(result));
  }

  Future<bool> saveTopRated(Result result) {
    return PrefHelper.storeCache(AppConstant.TOP_RATED, jsonEncode(result));
  }

  Future<bool> saveUpComing(Result result) {
    return PrefHelper.storeCache(AppConstant.UP_COMING, jsonEncode(result));
  }

}