import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class TvAiringTodayBloc extends Bloc<TvAiringTodayEvent, TvAiringTodayState> {
  final Repository repository;

  TvAiringTodayBloc({this.repository}) : super(InitialTvAiringToday());

  @override
  Stream<TvAiringTodayState> mapEventToState(TvAiringTodayEvent event) async* {
    if (event is LoadTvAiringToday) {
      yield* _mapLoadTvAiringTodayToState();
    }
  }

  Stream<TvAiringTodayState> _mapLoadTvAiringTodayToState() async* {
    try {
      yield TvAiringTodayLoading();
      var movies = await repository.getTvAiringToday(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield TvAiringTodayNoData(AppConstant.noData);
      } else {
        yield TvAiringTodayHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield TvAiringTodayNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield TvAiringTodayNoInternetConnection();
      } else {
        yield TvAiringTodayError(e.toString());
      }
    }
  }
}
