import 'package:equatable/equatable.dart';

sealed class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {
  const FetchNowPlayingMovies();
}