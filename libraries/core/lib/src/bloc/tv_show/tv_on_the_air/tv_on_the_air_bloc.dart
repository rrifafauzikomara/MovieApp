import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:shared/shared.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final Repository repository;

  TvOnTheAirBloc({this.repository}) : super(InitialTvOnTheAir());

  @override
  Stream<TvOnTheAirState> mapEventToState(TvOnTheAirEvent event) async* {
    if (event is LoadTvOnTheAir) {
      yield* _mapLoadTvOnTheAirToState();
    }
  }

  Stream<TvOnTheAirState> _mapLoadTvOnTheAirToState() async* {
    try {
      yield TvOnTheAirLoading();
      var movies = await repository.getTvOnTheAir(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield TvOnTheAirNoData(AppConstant.noData);
      } else {
        yield TvOnTheAirHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield TvOnTheAirNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield TvOnTheAirNoInternetConnection();
      } else {
        yield TvOnTheAirError(e.toString());
      }
    }
  }
}
