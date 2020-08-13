import 'package:equatable/equatable.dart';

abstract class TvAiringTodayEvent extends Equatable {
  const TvAiringTodayEvent();

  @override
  List<Object> get props => [];
}

class LoadTvAiringToday extends TvAiringTodayEvent {}
