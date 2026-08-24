import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/common/state_enum.dart';

import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieState: RequestState.Loading));

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
      await getMovieRecommendations.execute(event.id);

      detailResult.fold(
            (failure) {
          emit(state.copyWith(
            movieState: RequestState.Error,
            message: failure.message,
          ));
        },
            (movie) {
          emit(state.copyWith(
            recommendationState: RequestState.Loading,
            movie: movie,
          ));

          recommendationResult.fold(
                (failure) {
              emit(state.copyWith(
                movieState: RequestState.Loaded,
                movie: movie,
                recommendationState: RequestState.Error,
                message: failure.message,
              ));
            },
                (movies) {
              emit(state.copyWith(
                movieState: RequestState.Loaded,
                movie: movie,
                recommendationState: RequestState.Loaded,
                movieRecommendations: movies,
              ));
            },
          );
        },
      );
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });

    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

      String watchlistMessage = '';
      await result.fold(
            (failure) async => watchlistMessage = failure.message,
            (successMessage) async => watchlistMessage = successMessage,
      );

      final status = await getWatchListStatus.execute(event.movie.id);

      emit(state.copyWith(
        watchlistMessage: watchlistMessage,
        isAddedToWatchlist: status,
      ));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movie);

      String watchlistMessage = '';
      await result.fold(
            (failure) async => watchlistMessage = failure.message,
            (successMessage) async => watchlistMessage = successMessage,
      );

      final status = await getWatchListStatus.execute(event.movie.id);

      emit(state.copyWith(
        watchlistMessage: watchlistMessage,
        isAddedToWatchlist: status,
      ));
    });
  }
}