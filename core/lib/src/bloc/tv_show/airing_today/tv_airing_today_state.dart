import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class TvAiringTodayState extends Equatable {
  const TvAiringTodayState();

  @override
  List<Object> get props => [];
}

class InitialTvAiringToday extends TvAiringTodayState {}

class TvAiringTodayLoading extends TvAiringTodayState {}

class TvAiringTodayHasData extends TvAiringTodayState {
  final Result result;

  const TvAiringTodayHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class TvAiringTodayNoData extends TvAiringTodayState {}

class TvAiringTodayNoInternetConnection extends TvAiringTodayState {}

class TvAiringTodayError extends TvAiringTodayState {
  final String errorMessage;

  const TvAiringTodayError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
