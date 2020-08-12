import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final Repository repository;

  NowPlayingBloc({this.repository}) : super(InitialNowPlaying());

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    if (event is LoadNowPlaying) {
      yield* _mapLoadNowPlayingToState();
    }
  }

  Stream<NowPlayingState> _mapLoadNowPlayingToState() async* {
    try {
      yield NowPlayingLoading();
      var movies = await repository.getNowPlaying(
          ApiConstant.apiKey, ApiConstant.language);
      if (movies.results.isEmpty) {
        yield NowPlayingNoData();
      } else {
        yield NowPlayingHasData(movies);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        yield NowPlayingNoInternetConnection();
      } else if (e.type == DioErrorType.DEFAULT) {
        yield NowPlayingNoInternetConnection();
      } else {
        yield NowPlayingError(e.toString());
      }
    }
  }
}
