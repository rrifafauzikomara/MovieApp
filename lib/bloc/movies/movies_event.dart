import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadNowPlaying extends MoviesEvent {}

class LoadUpComing extends MoviesEvent {}

class LoadPopular extends MoviesEvent {}

class LoadTopRated extends MoviesEvent {}

class LoadMoreMovies extends MoviesEvent {
  final int page;

  LoadMoreMovies(this.page);

  @override
  List<Object> get props => [this.page];
}
