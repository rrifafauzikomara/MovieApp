import 'dart:io';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

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
    yield MoviesLoading();
    try {
      var movies = await repository.getNowPlaying(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on IOException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } on TimeoutException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } catch (e) {
      yield MoviesError(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadUpComingToState() async* {
    yield MoviesLoading();
    try {
      var movies = await repository.getUpComing(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on IOException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } on TimeoutException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } catch (e) {
      yield MoviesError(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadPopularToState() async* {
    yield MoviesLoading();
    try {
      var movies = await repository.getPopular(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on IOException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } on TimeoutException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } catch (e) {
      yield MoviesError(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadTopRatedToState() async* {
    yield MoviesLoading();
    try {
      var movies = await repository.getTopRated(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviesNoData(AppConstant.noData);
      } else {
        yield MoviesHasData(movies);
      }
    } on IOException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } on TimeoutException {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } catch (e) {
      yield MoviesError(e.toString());
    }
  }
}
