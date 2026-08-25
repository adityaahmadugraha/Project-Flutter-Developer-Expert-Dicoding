import 'package:ditonton/domain/entities/movie.dart';
import '../../../../movie/lib/domain/entities/movie_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final RequestState movieState;
  final MovieDetail? movie;

  final RequestState recommendationState;
  final List<Movie> movieRecommendations;

  final String message;

  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const MovieDetailState({
    this.movieState = RequestState.Empty,
    this.movie,
    this.recommendationState = RequestState.Empty,
    this.movieRecommendations = const [],
    this.message = '',
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
  });

  MovieDetailState copyWith({
    RequestState? movieState,
    MovieDetail? movie,
    RequestState? recommendationState,
    List<Movie>? movieRecommendations,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movieState: movieState ?? this.movieState,
      movie: movie ?? this.movie,
      recommendationState: recommendationState ?? this.recommendationState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
    movieState,
    movie,
    recommendationState,
    movieRecommendations,
    message,
    isAddedToWatchlist,
    watchlistMessage,
  ];
}