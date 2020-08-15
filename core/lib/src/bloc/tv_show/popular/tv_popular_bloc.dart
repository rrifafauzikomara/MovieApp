import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final Repository repository;

  TvPopularBloc({this.repository}) : super(InitialTvPopular());

  @override
  Stream<TvPopularState> mapEventToState(TvPopularEvent event) async* {
    if (event is LoadTvPopular) {
      yield* _mapLoadTvPopularToState();
    }
  }

  Stream<TvPopularState> _mapLoadTvPopularToState() async* {
    try {
      yield TvPopularLoading();
      var movies = await repository.getTvPopular(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield TvPopularNoData(AppConstant.noData);
      } else {
        yield TvPopularHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield TvPopularNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield TvPopularNoInternetConnection();
      } else {
        yield TvPopularError(e.toString());
      }
    }
  }
}
