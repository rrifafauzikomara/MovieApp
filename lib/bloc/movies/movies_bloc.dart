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
      yield* _mapLoadNowPlayingToState(1);
    } else if (event is LoadUpComing) {
      yield* _mapLoadUpComingToState(1);
    } else if (event is LoadPopular) {
      yield* _mapLoadPopularToState(1);
    } else if (event is LoadTopRated) {
      yield* _mapLoadTopRatedToState(1);
    }
  }

  Stream<MoviesState> _mapLoadNowPlayingToState(int page) async* {
    try {
      var currentMovies;
      if (state is MoviesLoaded) {
        currentMovies = (state as MoviesLoaded).result;
      } else {
        yield MoviesLoading();
      }

      var newMovies = await repository.getNowPlaying(
          ApiConstant.apiKey, ApiConstant.language, page);
      var resMovies;
      if (page > 1 && currentMovies != null) {
        resMovies = currentMovies..addAll(newMovies);
      } else {
        resMovies = newMovies;
      }
      yield MoviesLoaded(resMovies, page);
    } catch (e) {
      if (page == 1) yield MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadUpComingToState(int page) async* {
    try {
      var currentMovies;
      if (state is MoviesLoaded) {
        currentMovies = (state as MoviesLoaded).result;
      } else {
        yield MoviesLoading();
      }

      var newMovies = await repository.getUpComing(
          ApiConstant.apiKey, ApiConstant.language, page);
      var resMovies;
      if (page > 1 && currentMovies != null) {
        resMovies = currentMovies..addAll(newMovies);
      } else {
        resMovies = newMovies;
      }
      yield MoviesLoaded(resMovies, page);
    } catch (e) {
      if (page == 1) yield MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadPopularToState(int page) async* {
    try {
      var currentMovies;
      if (state is MoviesLoaded) {
        currentMovies = (state as MoviesLoaded).result;
      } else {
        yield MoviesLoading();
      }

      var newMovies = await repository.getPopular(
          ApiConstant.apiKey, ApiConstant.language, page);
      var resMovies;
      if (page > 1 && currentMovies != null) {
        resMovies = currentMovies..addAll(newMovies);
      } else {
        resMovies = newMovies;
      }
      yield MoviesLoaded(resMovies, page);
    } catch (e) {
      if (page == 1) yield MoviesNotLoaded(e.toString());
    }
  }

  Stream<MoviesState> _mapLoadTopRatedToState(int page) async* {
    try {
      var currentMovies;
      if (state is MoviesLoaded) {
        currentMovies = (state as MoviesLoaded).result;
      } else {
        yield MoviesLoading();
      }

      var newMovies = await repository.getTopRated(
          ApiConstant.apiKey, ApiConstant.language, page);
      var resMovies;
      if (page > 1 && currentMovies != null) {
        resMovies = currentMovies..addAll(newMovies);
      } else {
        resMovies = newMovies;
      }
      yield MoviesLoaded(resMovies, page);
    } catch (e) {
      if (page == 1) yield MoviesNotLoaded(e.toString());
    }
  }
}
