import 'package:equatable/equatable.dart';

sealed class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingTv extends TvListEvent {
  const FetchNowPlayingTv();
}

class FetchPopularTv extends TvListEvent {
  const FetchPopularTv();
}

class FetchTopRatedTv extends TvListEvent {
  const FetchTopRatedTv();
}