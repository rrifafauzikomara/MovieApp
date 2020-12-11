import 'package:equatable/equatable.dart';

abstract class DiscoverMovieEvent extends Equatable {
  const DiscoverMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadDiscoverMovie extends DiscoverMovieEvent {}