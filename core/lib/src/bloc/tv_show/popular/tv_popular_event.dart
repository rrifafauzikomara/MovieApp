import 'package:equatable/equatable.dart';

abstract class TvPopularEvent extends Equatable {
  const TvPopularEvent();

  @override
  List<Object> get props => [];
}

class LoadTvPopular extends TvPopularEvent {}
