import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final Repository repository;

  MovieNowPlayingBloc({this.repository}) : super(InitialMovieNowPlaying());

  @override
  Stream<MovieNowPlayingState> mapEventToState(MovieNowPlayingEvent event) async* {
    if (event is LoadMovieNowPlaying) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<MovieNowPlayingState> _mapLoadNowPlayingToState() async* {
    try {
      yield MovieNowPlayingLoading();
      var movies = await repository.getMovieNowPlaying(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MovieNowPlayingNoData(AppConstant.noData);
      } else {
        yield MovieNowPlayingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MovieNowPlayingNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MovieNowPlayingNoInternetConnection();
      } else {
        yield MovieNowPlayingError(e.toString());
      }
    }
  }
}
