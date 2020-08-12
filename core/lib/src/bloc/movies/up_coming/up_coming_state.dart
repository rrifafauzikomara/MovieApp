import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class UpComingState extends Equatable {
  const UpComingState();

  @override
  List<Object> get props => [];
}

class InitialUpComing extends UpComingState {}

class UpComingLoading extends UpComingState {}

class UpComingHasData extends UpComingState {
  final Result result;

  const UpComingHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class UpComingNoData extends UpComingState {}

class UpComingNoInternetConnection extends UpComingState {}

class UpComingError extends UpComingState {
  final String errorMessage;

  UpComingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}