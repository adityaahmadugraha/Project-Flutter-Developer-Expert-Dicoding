import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';

import 'watchlist_movie_event.dart';
import 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(const WatchlistMovieEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(const WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();
      result.fold(
            (failure) => emit(WatchlistMovieError(failure.message)),
            (data) => emit(WatchlistMovieHasData(data)),
      );
    });
  }
}
