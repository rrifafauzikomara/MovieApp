import 'package:equatable/equatable.dart';

abstract class TrailerEvent extends Equatable {
  final int movieId;

  const TrailerEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class LoadTrailer extends TrailerEvent {
  LoadTrailer(int movieId) : super(movieId);
}
