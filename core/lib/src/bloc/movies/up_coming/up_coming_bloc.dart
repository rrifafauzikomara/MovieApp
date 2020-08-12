import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpComingBloc extends Bloc<UpComingEvent, UpComingState> {
  final Repository repository;

  UpComingBloc({this.repository}) : super(InitialUpComing());

  @override
  Stream<UpComingState> mapEventToState(UpComingEvent event) async* {
    if (event is LoadUpComing) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<UpComingState> _mapLoadNowPlayingToState() async* {
    try {
      yield UpComingLoading();
      var movies = await repository.getUpComing(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield UpComingNoData();
      } else {
        yield UpComingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield UpComingNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield UpComingNoInternetConnection();
      } else {
        yield UpComingError(e.toString());
      }
    }
  }

}