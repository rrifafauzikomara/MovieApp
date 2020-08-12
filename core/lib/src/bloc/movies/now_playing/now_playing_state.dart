import 'package:equatable/equatable.dart';
import 'package:core/core.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class InitialNowPlaying extends NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingHasData extends NowPlayingState {
  final Result result;

  const NowPlayingHasData([this.result]);

  @override
  List<Object> get props => [result];
}

class NowPlayingNoData extends NowPlayingState {}

class NowPlayingNoInternetConnection extends NowPlayingState {}

class NowPlayingError extends NowPlayingState {

  final String errorMessage;

  const NowPlayingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

}