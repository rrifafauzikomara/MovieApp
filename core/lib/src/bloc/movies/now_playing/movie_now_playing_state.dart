import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

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

class MovieNowPlayingNoData extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingNoData(this.message);

  @override
  List<Object> get props => [message];
}

class MovieNowPlayingNoInternetConnection extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String errorMessage;

  const MovieNowPlayingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
