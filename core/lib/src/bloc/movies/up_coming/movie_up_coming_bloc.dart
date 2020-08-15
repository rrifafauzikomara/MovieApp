import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class MovieUpComingBloc extends Bloc<MovieUpComingEvent, MovieUpComingState> {
  final Repository repository;

  MovieUpComingBloc({this.repository}) : super(InitialMovieUpComing());

  @override
  Stream<MovieUpComingState> mapEventToState(MovieUpComingEvent event) async* {
    if (event is LoadMovieUpComing) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<MovieUpComingState> _mapLoadNowPlayingToState() async* {
    try {
      yield MovieUpComingLoading();
      var movies = await repository.getMovieUpComing(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MovieUpComingNoData(AppConstant.noData);
      } else {
        yield MovieUpComingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MovieUpComingNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MovieUpComingNoInternetConnection();
      } else {
        yield MovieUpComingError(e.toString());
      }
    }
  }
}
