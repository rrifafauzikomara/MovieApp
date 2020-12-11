import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class MovieRepository implements Repository {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;

  MovieRepository(
      {@required this.apiRepository, @required this.localRepository});

  @override
  Future<Result> getMovieNowPlaying(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal =
          await localRepository.getMovieNowPlaying(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getMovieNowPlaying(apiKey, language);
      localRepository.saveMovieNowPlaying(data);
      return data;
    }
  }

  @override
  Future<Result> getMovieUpComing(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getMovieUpComing(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getMovieUpComing(apiKey, language);
      localRepository.saveMovieUpComing(data);
      return data;
    }
  }

  @override
  Future<Result> getMoviePopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getMoviePopular(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getMoviePopular(apiKey, language);
      localRepository.saveMoviePopular(data);
      return data;
    }
  }

  @override
  Future<Result> getTvAiringToday(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getTvAiringToday(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getTvAiringToday(apiKey, language);
      localRepository.saveTvAiringToday(data);
      return data;
    }
  }

  @override
  Future<Result> getTvPopular(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getTvPopular(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getTvPopular(apiKey, language);
      localRepository.saveTvPopular(data);
      return data;
    }
  }

  @override
  Future<Result> getTvOnTheAir(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getTvOnTheAir(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getTvOnTheAir(apiKey, language);
      localRepository.saveTvOnTheAir(data);
      return data;
    }
  }

  @override
  Future<ResultCrew> getMovieCrew(
      [int movieId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    final data = await apiRepository.getMovieCrew(movieId, apiKey, language);
    return data;
  }

  @override
  Future<ResultTrailer> getMovieTrailer(int movieId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    final data = await apiRepository.getMovieTrailer(movieId, apiKey, language);
    return data;
  }

  @override
  Future<ResultCrew> getTvShowCrew(
      [int tvId,
      String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    final data = await apiRepository.getTvShowCrew(tvId, apiKey, language);
    return data;
  }

  @override
  Future<ResultTrailer> getTvShowTrailer(int tvId,
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    final data = await apiRepository.getTvShowTrailer(tvId, apiKey, language);
    return data;
  }

  @override
  Future<Result> getDiscoverMovie(
      [String apiKey = ApiConstant.apiKey,
      String language = ApiConstant.language]) async {
    try {
      var fromLocal = await localRepository.getDiscoverMovie(apiKey, language);
      if (fromLocal != null) {
        return fromLocal;
      } else {
        throw Exception();
      }
    } catch (_) {
      final data = await apiRepository.getDiscoverMovie(apiKey, language);
      localRepository.saveDiscoverMovie(data);
      return data;
    }
  }
}
