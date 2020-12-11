import 'package:equatable/equatable.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieNowPlaying extends MovieNowPlayingEvent {}