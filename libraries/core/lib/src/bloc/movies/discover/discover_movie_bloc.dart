import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DiscoverMovieBloc extends Bloc<DiscoverMovieEvent, DiscoverMovieState> {
  final Repository repository;

  DiscoverMovieBloc({this.repository}) : super(InitialDiscoverMovie());

  @override
  Stream<DiscoverMovieState> mapEventToState(DiscoverMovieEvent event) async* {
    if (event is LoadDiscoverMovie) {
      yield* _mapLoadDiscoverMovieToState();
    }
  }

  Stream<DiscoverMovieState> _mapLoadDiscoverMovieToState() async* {
    try {
      yield DiscoverMovieLoading();
      var movies = await repository.getDiscoverMovie(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield DiscoverMovieNoData(AppConstant.noData);
      } else {
        yield DiscoverMovieHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield DiscoverMovieNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield DiscoverMovieNoInternetConnection();
      } else {
        yield DiscoverMovieError(e.toString());
      }
    }
  }
}
