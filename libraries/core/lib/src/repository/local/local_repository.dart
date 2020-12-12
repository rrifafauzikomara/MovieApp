import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/src/local/shared_pref_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared/shared.dart';

class LocalRepository implements Repository {
  final SharedPrefHelper prefHelper;

  LocalRepository({@required this.prefHelper});

  @override
  Future<Result> getMovieNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.MOVIE_NOW_PLAYING);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getMovieUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.MOVIE_UP_COMING);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getMoviePopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.MOVIE_POPULAR);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveMovieNowPlaying(Result result) {
    return prefHelper.storeCache(
        AppConstant.MOVIE_NOW_PLAYING, jsonEncode(result));
  }

  Future<bool> saveMovieUpComing(Result result) {
    return prefHelper.storeCache(
        AppConstant.MOVIE_UP_COMING, jsonEncode(result));
  }

  Future<bool> saveMoviePopular(Result result) {
    return prefHelper.storeCache(AppConstant.MOVIE_POPULAR, jsonEncode(result));
  }

  @override
  Future<Result> getTvAiringToday(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.TV_AIRING_TODAY);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getTvPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.TV_POPULAR);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  @override
  Future<Result> getTvOnTheAir(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.TV_ON_THE_AIR);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveTvAiringToday(Result result) {
    return prefHelper.storeCache(
        AppConstant.TV_AIRING_TODAY, jsonEncode(result));
  }

  Future<bool> saveTvPopular(Result result) {
    return prefHelper.storeCache(AppConstant.TV_POPULAR, jsonEncode(result));
  }

  Future<bool> saveTvOnTheAir(Result result) {
    return prefHelper.storeCache(AppConstant.TV_ON_THE_AIR, jsonEncode(result));
  }

  @override
  Future<ResultCrew> getMovieCrew(
      [int movieId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultTrailer> getMovieTrailer(int movieId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultCrew> getTvShowCrew(
      [int tvId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<ResultTrailer> getTvShowTrailer(int tvId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) {
    throw UnimplementedError();
  }

  @override
  Future<Result> getDiscoverMovie(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    var fromCache = await prefHelper.getCache(AppConstant.DISCOVER_MOVIE);
    if (fromCache != null) {
      Map json = jsonDecode(fromCache);
      return Result.fromJson(json);
    }
    return null;
  }

  Future<bool> saveDiscoverMovie(Result result) {
    return prefHelper.storeCache(
        AppConstant.DISCOVER_MOVIE, jsonEncode(result));
  }
}
