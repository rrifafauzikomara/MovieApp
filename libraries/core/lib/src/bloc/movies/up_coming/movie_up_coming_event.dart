import 'package:equatable/equatable.dart';

abstract class MovieUpComingEvent extends Equatable {
  const MovieUpComingEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieUpComing extends MovieUpComingEvent {}