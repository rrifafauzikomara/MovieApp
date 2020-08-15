import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final Repository repository;

  TrailerBloc({this.repository}) : super(InitialTrailer());

  @override
  Stream<TrailerState> mapEventToState(TrailerEvent event) async* {
    if (event is LoadTrailer) {
      if (event.isFromMovie) {
        yield* _mapLoadMovieTrailerToState(event.movieId);
      } else if (!event.isFromMovie) {
        yield* _mapLoadTvShowTrailerToState(event.movieId);
      }
    }
  }

  Stream<TrailerState> _mapLoadMovieTrailerToState(int movieId) async* {
    try {
      yield TrailerLoading();
      var movies = await repository.getMovieTrailer(
          movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.trailer.isEmpty) {
        yield TrailerNoData(AppConstant.noTrailer);
      } else {
        yield TrailerHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield TrailerNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield TrailerNoInternetConnection();
      } else {
        yield TrailerError(e.toString());
      }
    }
  }

  Stream<TrailerState> _mapLoadTvShowTrailerToState(int movieId) async* {
    try {
      yield TrailerLoading();
      var tvShow = await repository.getTvShowTrailer(
          movieId, ApiConstant.apiKey, ApiConstant.language);
      if (tvShow.trailer.isEmpty) {
        yield TrailerNoData(AppConstant.noTrailer);
      } else {
        yield TrailerHasData(tvShow);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield TrailerNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield TrailerNoInternetConnection();
      } else {
        yield TrailerError(e.toString());
      }
    }
  }
}
