import 'package:equatable/equatable.dart';

abstract class TrailerEvent extends Equatable {
  final int movieId;
  final bool isFromMovie;

  const TrailerEvent(this.movieId, this.isFromMovie);

  @override
  List<Object> get props => [movieId];
}

class LoadTrailer extends TrailerEvent {
  LoadTrailer(int movieId, bool isFromMovie) : super(movieId, isFromMovie);
}
