import 'package:equatable/equatable.dart';

abstract class CrewEvent extends Equatable {
  final int movieId;

  const CrewEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class LoadCrew extends CrewEvent {
  LoadCrew(int movieId) : super(movieId);
}
