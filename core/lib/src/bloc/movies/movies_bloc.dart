import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Repository repository;

  MoviesBloc(this.repository);

  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is LoadNowPlaying) {
      yield* _mapLoadNowPlayingToState();
    } else if (event is LoadUpComing) {
      yield* _mapLoadUpComingToState();
    } else if (event is LoadPopular) {
      yield* _mapLoadPopularToState();
    } else if (event is LoadTopRated) {
      yield* _mapLoadTopRatedToState();
    }
  }

  Stream<MoviesState> _mapLoadNowPlayingToState() async* {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } else {
      try {
        yield MoviesLoading();
        var movies = await repository.getNowPlaying(ApiConstant.apiKey, ApiConstant.language);
        if (movies.results.isEmpty) {
          yield MoviesNoData(AppConstant.noData);
        } else {
          yield MoviesHasData(movies);
        }
      } catch (e) {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadUpComingToState() async* {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } else {
      try {
        yield MoviesLoading();
        var movies = await repository.getUpComing(ApiConstant.apiKey, ApiConstant.language);
        if (movies.results.isEmpty) {
          yield MoviesNoData(AppConstant.noData);
        } else {
          yield MoviesHasData(movies);
        }
      } catch (e) {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadPopularToState() async* {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } else {
      try {
        yield MoviesLoading();
        var movies = await repository.getPopular(ApiConstant.apiKey, ApiConstant.language);
        if (movies.results.isEmpty) {
          yield MoviesNoData(AppConstant.noData);
        } else {
          yield MoviesHasData(movies);
        }
      } catch (e) {
        yield MoviesError(e.toString());
      }
    }
  }

  Stream<MoviesState> _mapLoadTopRatedToState() async* {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield MoviesNoInternetConnection(AppConstant.noInternetConnection);
    } else {
      try {
        yield MoviesLoading();
        var movies = await repository.getTopRated(ApiConstant.apiKey, ApiConstant.language);
        if (movies.results.isEmpty) {
          yield MoviesNoData(AppConstant.noData);
        } else {
          yield MoviesHasData(movies);
        }
      } catch (e) {
        yield MoviesError(e.toString());
      }
    }
  }
}
