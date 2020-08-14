import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class TrailerState extends Equatable {
  const TrailerState();

  @override
  List<Object> get props => [];
}

class InitialTrailer extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailerHasData extends TrailerState {
  final ResultTrailer trailer;

  const TrailerHasData([this.trailer]);

  @override
  List<Object> get props => [trailer];
}

class TrailerNoData extends TrailerState {}

class TrailerNoInternetConnection extends TrailerState {}

class TrailerError extends TrailerState {
  final String errorMessage;

  const TrailerError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
