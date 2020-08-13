import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class InitialTvPopular extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularHasData extends TvPopularState {
  final Result result;

  const TvPopularHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class TvPopularNoData extends TvPopularState {}

class TvPopularNoInternetConnection extends TvPopularState {}

class TvPopularError extends TvPopularState {
  final String errorMessage;

  const TvPopularError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
