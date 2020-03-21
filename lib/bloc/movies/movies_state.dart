import 'package:equatable/equatable.dart';
import 'package:moviecatalogue/network/api/rest_client.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class InitialMoviesState extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoadingMore extends MoviesState{}

class MoviesLoaded extends MoviesState {
  final Result result;
  final int page;

  const MoviesLoaded([this.result, this.page = 1]);

  @override
  List<Object> get props => [result, page];
}

class MoviesNotLoaded extends MoviesState {
  final String errorMessage;

  const MoviesNotLoaded(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() => 'LoginFailure { error: $errorMessage }';
}
