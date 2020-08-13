import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class InitialMovieNowPlaying extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final Result result;

  const MovieNowPlayingHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class MovieNowPlayingNoData extends MovieNowPlayingState {}

class MovieNowPlayingNoInternetConnection extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {

  final String errorMessage;

  const MovieNowPlayingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}