
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

sealed class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvEmpty extends NowPlayingTvState {
  const NowPlayingTvEmpty();
}

class NowPlayingTvLoading extends NowPlayingTvState {
  const NowPlayingTvLoading();
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;
  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvHasData extends NowPlayingTvState {
  final List<Tv> result;
  const NowPlayingTvHasData(this.result);

  @override
  List<Object> get props => [result];
}