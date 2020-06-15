import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';
import 'package:dio/dio.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Repository repository;

  MoviesBloc(this.repository);

  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is LoadNowPlaying) {
      yield* _mapLoadNowPlayingToState();
    } else if (event is LoadUpComing) {
      yield* _mapLoadUpComingToState();
    } else if (event is LoadPopular) {
      yield* _mapLoadPopularToState();
    } else if (event is LoadTopRated) {
      yield* _mapLoadTopRatedToState();
    }
  }

  Stream<MoviesState> _mapLoadNowPlayingToState() async* {
    try {
      yield MoviesLoading();
      var movies = await repository.getNowPlaying(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadUpComingToState() async* {
    try {
      yield MoviesLoading();
      var movies = await repository.getUpComing(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadPopularToState() async* {
    try {
      yield MoviesLoading();
      var movies = await repository.getPopular(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadTopRatedToState() async* {
    try {
      yield MoviesLoading();
      var movies = await repository.getTopRated(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
      } else {
        yield MoviesError(e.toString());
      }
    }
  }
}
