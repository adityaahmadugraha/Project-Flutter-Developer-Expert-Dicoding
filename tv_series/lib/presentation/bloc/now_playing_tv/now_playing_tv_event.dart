import 'package:equatable/equatable.dart';

sealed class NowPlayingTvEvent extends Equatable {
  const NowPlayingTvEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingTv extends NowPlayingTvEvent {
  const FetchNowPlayingTv();
}