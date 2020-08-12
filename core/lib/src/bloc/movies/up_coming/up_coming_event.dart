import 'package:equatable/equatable.dart';

abstract class UpComingEvent extends Equatable {
  const UpComingEvent();

  @override
  List<Object> get props => [];
}

class LoadUpComing extends UpComingEvent {}