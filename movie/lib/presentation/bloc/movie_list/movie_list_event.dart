import 'package:equatable/equatable.dart';

sealed class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieListEvent {
  const FetchNowPlayingMovies();
}

class FetchPopularMovies extends MovieListEvent {
  const FetchPopularMovies();
}

class FetchTopRatedMovies extends MovieListEvent {
  const FetchTopRatedMovies();
}