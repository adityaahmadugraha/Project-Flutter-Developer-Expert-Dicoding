import 'package:equatable/equatable.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends WatchlistMovieEvent {
  const FetchWatchlistMovies();
}