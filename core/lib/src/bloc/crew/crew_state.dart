import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

abstract class CrewState extends Equatable {
  const CrewState();

  @override
  List<Object> get props => [];
}

class InitialCrew extends CrewState {}

class CrewLoading extends CrewState {}

class CrewHasData extends CrewState {
  final ResultCrew crew;

  const CrewHasData([this.crew]);

  @override
  List<Object> get props => [crew];
}

class CrewNoData extends CrewState {
  final String message;

  const CrewNoData(this.message);

  @override
  List<Object> get props => [message];
}

class CrewNoInternetConnection extends CrewState {}

class CrewError extends CrewState {
  final String errorMessage;

  const CrewError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
