import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class CrewBloc extends Bloc<CrewEvent, CrewState> {
  final Repository repository;

  CrewBloc({this.repository}) : super(InitialCrew());

  @override
  Stream<CrewState> mapEventToState(CrewEvent event) async* {
    if (event is LoadCrew) {
      yield* _mapLoadCrewToState(event.movieId, event.isFromMovie);
    }
  }

  Stream<CrewState> _mapLoadCrewToState(int movieId, bool isFromMovie) async* {
    try {
      yield CrewLoading();
      var movies = await repository.getMovieCrew(
          movieId, ApiConstant.apiKey, ApiConstant.language);
      var tvShow = await repository.getTvShowCrew(movieId, ApiConstant.apiKey, ApiConstant.language);
      if (isFromMovie) {
        if (movies.crew.isEmpty) {
          yield CrewNoData();
        } else {
          yield CrewHasData(movies);
        }
      } else {
        if (tvShow.crew.isEmpty) {
          yield CrewNoData();
        } else {
          yield CrewHasData(tvShow);
        }
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
