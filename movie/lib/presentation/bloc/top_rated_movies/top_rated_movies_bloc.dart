import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';

import 'top_rated_movies_event.dart';
import 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc(this.getTopRatedMovies)
      : super(const TopRatedMoviesEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(const TopRatedMoviesLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
            (failure) => emit(TopRatedMoviesError(failure.message)),
            (data) => emit(TopRatedMoviesHasData(data)),
      );
    });
  }
}