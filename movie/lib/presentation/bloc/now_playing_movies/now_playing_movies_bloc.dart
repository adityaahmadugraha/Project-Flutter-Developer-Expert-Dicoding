import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

import 'now_playing_movies_event.dart';
import 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(const NowPlayingMoviesEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(const NowPlayingMoviesLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
            (failure) => emit(NowPlayingMoviesError(failure.message)),
            (data) => emit(NowPlayingMoviesHasData(data)),
      );
    });
  }
}