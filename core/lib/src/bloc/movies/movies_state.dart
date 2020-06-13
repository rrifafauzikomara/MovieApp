import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class InitialMoviesState extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesHasData extends MoviesState {
  final Result result;

  const MoviesHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class MoviesNoData extends MoviesState {}

class MoviesNoInternetConnection extends MoviesState {}

class MoviesError extends MoviesState {
  final String errorMessage;

  const MoviesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'LoginFailure { error: $errorMessage }';
}
