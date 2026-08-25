import 'package:equatable/equatable.dart';

sealed class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class FetchTvListNowPlaying extends TvListEvent {
  const FetchTvListNowPlaying();
}

class FetchTvListPopular extends TvListEvent {
  const FetchTvListPopular();
}

class FetchTvListTopRated extends TvListEvent {
  const FetchTvListTopRated();
}