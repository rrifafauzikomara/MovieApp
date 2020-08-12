import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class InitialPopular extends PopularState {}

class PopularLoading extends PopularState {}

class PopularHasData extends PopularState {
  final Result result;

  const PopularHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class PopularNoData extends PopularState {}

class PopularNoInternetConnection extends PopularState {}

class PopularError extends PopularState {
  final String errorMessage;

  PopularError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}