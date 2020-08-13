import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class InitialMoviePopular extends MoviePopularState {}

class MoviePopularLoading extends MoviePopularState {}

class MoviePopularHasData extends MoviePopularState {
  final Result result;

  const MoviePopularHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class MoviePopularNoData extends MoviePopularState {}

class MoviePopularNoInternetConnection extends MoviePopularState {}

class MoviePopularError extends MoviePopularState {
  final String errorMessage;

  MoviePopularError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}