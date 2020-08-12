import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final Repository repository;

  PopularBloc({this.repository}) : super(InitialPopular());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    if (event is LoadPopular) {
      yield* _mapLoadPopularToState();
    }
  }

  Stream<PopularState> _mapLoadPopularToState() async* {
    try {
      yield PopularLoading();
      var movies = await repository.getPopular(ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield PopularNoData();
      } else {
        yield PopularHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield PopularNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield PopularNoInternetConnection();
      } else {
        yield PopularError(e.toString());
      }
    }
  }

}