import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class CrewBloc extends Bloc<CrewEvent, CrewState> {
  final Repository repository;

  CrewBloc({this.repository}) : super(InitialCrew());

  @override
  Stream<CrewState> mapEventToState(CrewEvent event) async* {
    if (event is LoadCrew) {
      if (event.isFromMovie) {
        yield* _mapLoadMovieCrewToState(event.movieId);
      } else if (!event.isFromMovie) {
        yield* _mapLoadTvShowCrewToState(event.movieId);
      }
    }
  }

  Stream<CrewState> _mapLoadMovieCrewToState(int movieId) async* {
    try {
      yield CrewLoading();
      var movies = await repository.getMovieCrew(
          movieId, ApiConstant.apiKey, ApiConstant.language);
      if (movies.crew.isEmpty) {
        yield CrewNoData(AppConstant.noCrew);
      } else {
        yield CrewHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield CrewNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield CrewNoInternetConnection();
      } else {
        yield CrewError(e.toString());
      }
    }
  }

  Stream<CrewState> _mapLoadTvShowCrewToState(int tvId) async* {
    try {
      yield CrewLoading();
      var tvShow = await repository.getTvShowCrew(
          tvId, ApiConstant.apiKey, ApiConstant.language);
      if (tvShow.crew.isEmpty) {
        yield CrewNoData(AppConstant.noCrew);
      } else {
        yield CrewHasData(tvShow);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield CrewNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield CrewNoInternetConnection();
      } else {
        yield CrewError(e.toString());
      }
    }
  }
}
