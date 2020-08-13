import 'package:equatable/equatable.dart';

abstract class TvOnTheAirEvent extends Equatable {
  const TvOnTheAirEvent();

  @override
  List<Object> get props => [];
}

class LoadTvOnTheAir extends TvOnTheAirEvent {}
