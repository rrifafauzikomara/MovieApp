import 'package:equatable/equatable.dart';

abstract class CrewEvent extends Equatable {
  final int movieId;
  final bool isFromMovie;

  const CrewEvent(this.movieId, this.isFromMovie);

  @override
  List<Object> get props => [movieId];
}

class LoadCrew extends CrewEvent {
  LoadCrew(int movieId, bool isFromMovie) : super(movieId, isFromMovie);
}
