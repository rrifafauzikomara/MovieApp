import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final Repository repository;

  MoviePopularBloc({this.repository}) : super(InitialMoviePopular());

  @override
  Stream<MoviePopularState> mapEventToState(MoviePopularEvent event) async* {
    if (event is LoadMoviePopular) {
      yield* _mapLoadPopularToState();
    }
  }

  Stream<MoviePopularState> _mapLoadPopularToState() async* {
    try {
      yield MoviePopularLoading();
      var movies = await repository.getMoviePopular(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield MoviePopularNoData(AppConstant.noData);
      } else {
        yield MoviePopularHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield MoviePopularNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield MoviePopularNoInternetConnection();
      } else {
        yield MoviePopularError(e.toString());
      }
    }
  }
}
