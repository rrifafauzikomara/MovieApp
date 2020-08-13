import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class MovieUpComingState extends Equatable {
  const MovieUpComingState();

  @override
  List<Object> get props => [];
}

class InitialMovieUpComing extends MovieUpComingState {}

class MovieUpComingLoading extends MovieUpComingState {}

class MovieUpComingHasData extends MovieUpComingState {
  final Result result;

  const MovieUpComingHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class MovieUpComingNoData extends MovieUpComingState {}

class MovieUpComingNoInternetConnection extends MovieUpComingState {}

class MovieUpComingError extends MovieUpComingState {
  final String errorMessage;

  MovieUpComingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}