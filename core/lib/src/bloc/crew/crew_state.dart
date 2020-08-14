import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

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

class CrewNoData extends CrewState {}

class CrewNoInternetConnection extends CrewState {}

class CrewError extends CrewState {

  final String errorMessage;

  const CrewError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}