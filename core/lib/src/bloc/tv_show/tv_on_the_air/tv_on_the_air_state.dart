import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();

  @override
  List<Object> get props => [];
}

class InitialTvOnTheAir extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirHasData extends TvOnTheAirState {
  final Result result;

  const TvOnTheAirHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class TvOnTheAirNoData extends TvOnTheAirState {
  final String message;

  const TvOnTheAirNoData(this.message);

  @override
  List<Object> get props => [message];
}

class TvOnTheAirNoInternetConnection extends TvOnTheAirState {}

class TvOnTheAirError extends TvOnTheAirState {
  final String errorMessage;

  const TvOnTheAirError([this.errorMessage]);

  @override
  List<Object> get props => [errorMessage];
}
