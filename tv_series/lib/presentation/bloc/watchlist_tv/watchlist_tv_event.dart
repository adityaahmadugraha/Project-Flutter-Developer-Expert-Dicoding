import 'package:equatable/equatable.dart';

sealed class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends WatchlistTvEvent {
  const FetchWatchlistTv();
}