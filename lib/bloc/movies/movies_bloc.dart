import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviecatalogue/bloc/movies/movies_event.dart';
import 'package:moviecatalogue/bloc/movies/movies_state.dart';
import 'package:moviecatalogue/cons/api_constant.dart';
import 'package:moviecatalogue/network/repository/repository.dart';

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
    try {
      yield MoviesLoading();

      // call api
      var movies = await repository.getNowPlaying(ApiConstant.apiKey, ApiConstant.language);
      yield MoviesLoaded(movies);
    } catch (e) {
      yield MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadUpComingToState() async* {
    try {
      yield MoviesLoading();

      // call api
      var movies = await repository.getUpComing(ApiConstant.apiKey, ApiConstant.language);
      yield MoviesLoaded(movies);
    } catch (e) {
      MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadPopularToState() async* {
    try {
      yield MoviesLoading();

      // call api
      var movies = await repository.getPopular(ApiConstant.apiKey, ApiConstant.language);
      yield MoviesLoaded(movies);
    } catch (e) {
      MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadTopRatedToState() async* {
    try {
      yield MoviesLoading();

      // call api
      var movies = await repository.getTopRated(ApiConstant.apiKey, ApiConstant.language);
      yield MoviesLoaded(movies);
    } catch (e) {
      MoviesNotLoaded(e.toString());
    }
  }
}
