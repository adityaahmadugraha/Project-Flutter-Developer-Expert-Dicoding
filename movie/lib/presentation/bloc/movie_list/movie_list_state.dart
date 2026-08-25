import 'package:movie/domain/entities/movie.dart';
import 'package:core/common/state_enum.dart';
import 'package:equatable/equatable.dart';

class MovieListState extends Equatable {
  final RequestState nowPlayingState;
  final List<Movie> nowPlayingMovies;

  final RequestState popularMoviesState;
  final List<Movie> popularMovies;

  final RequestState topRatedMoviesState;
  final List<Movie> topRatedMovies;

  final String message;

  const MovieListState({
    this.nowPlayingState = RequestState.Empty,
    this.nowPlayingMovies = const [],
    this.popularMoviesState = RequestState.Empty,
    this.popularMovies = const [],
    this.topRatedMoviesState = RequestState.Empty,
    this.topRatedMovies = const [],
    this.message = '',
  });

  MovieListState copyWith({
    RequestState? nowPlayingState,
    List<Movie>? nowPlayingMovies,
    RequestState? popularMoviesState,
    List<Movie>? popularMovies,
    RequestState? topRatedMoviesState,
    List<Movie>? topRatedMovies,
    String? message,
  }) {
    return MovieListState(
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
    nowPlayingState,
    nowPlayingMovies,
    popularMoviesState,
    popularMovies,
    topRatedMoviesState,
    topRatedMovies,
    message,
  ];
}