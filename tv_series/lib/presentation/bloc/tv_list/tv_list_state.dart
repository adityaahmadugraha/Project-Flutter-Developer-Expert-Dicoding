import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

class TvListState extends Equatable {
  final RequestState nowPlayingState;
  final List<Tv> nowPlayingTv;

  final RequestState popularTvState;
  final List<Tv> popularTv;

  final RequestState topRatedTvState;
  final List<Tv> topRatedTv;

  final String message;

  const TvListState({
    this.nowPlayingState = RequestState.Empty,
    this.nowPlayingTv = const [],
    this.popularTvState = RequestState.Empty,
    this.popularTv = const [],
    this.topRatedTvState = RequestState.Empty,
    this.topRatedTv = const [],
    this.message = '',
  });

  TvListState copyWith({
    RequestState? nowPlayingState,
    List<Tv>? nowPlayingTv,
    RequestState? popularTvState,
    List<Tv>? popularTv,
    RequestState? topRatedTvState,
    List<Tv>? topRatedTv,
    String? message,
  }) {
    return TvListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingTv: nowPlayingTv ?? this.nowPlayingTv,
      popularTvState: popularTvState ?? this.popularTvState,
      popularTv: popularTv ?? this.popularTv,
      topRatedTvState: topRatedTvState ?? this.topRatedTvState,
      topRatedTv: topRatedTv ?? this.topRatedTv,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    nowPlayingState,
    nowPlayingTv,
    popularTvState,
    popularTv,
    topRatedTvState,
    topRatedTv,
    message,
  ];
}