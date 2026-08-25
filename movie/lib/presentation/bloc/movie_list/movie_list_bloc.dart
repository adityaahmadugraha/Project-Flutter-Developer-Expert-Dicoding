import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:core/common/state_enum.dart';

import '../../../domain/usecases/get_popular_movies.dart';
import 'movie_list_event.dart';
import 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(const MovieListState()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));

      final result = await getNowPlayingMovies.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: data,
        )),
      );
    });

    on<FetchPopularMovies>((event, emit) async {
      emit(state.copyWith(popularMoviesState: RequestState.Loading));

      final result = await getPopularMovies.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          popularMoviesState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: data,
        )),
      );
    });

    on<FetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(topRatedMoviesState: RequestState.Loading));

      final result = await getTopRatedMovies.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          topRatedMoviesState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: data,
        )),
      );
    });
  }
}