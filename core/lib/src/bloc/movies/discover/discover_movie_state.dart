import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

abstract class DiscoverMovieState extends Equatable {
  const DiscoverMovieState();

  @override
  List<Object> get props => [];
}

class InitialDiscoverMovie extends DiscoverMovieState {}

class DiscoverMovieLoading extends DiscoverMovieState {}

class DiscoverMovieHasData extends DiscoverMovieState {
  final Result result;

  const DiscoverMovieHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class DiscoverMovieNoData extends DiscoverMovieState {
  final String message;

  const DiscoverMovieNoData(this.message);

  @override
  List<Object> get props => [message];
}

class DiscoverMovieNoInternetConnection extends DiscoverMovieState {}

class DiscoverMovieError extends DiscoverMovieState {
  final String errorMessage;

  const DiscoverMovieError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
