import 'package:bloc/bloc.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:stream_transform/stream_transform.dart';

import 'movie_search_event.dart';
import 'movie_search_state.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> _debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies})
      : super(const MovieSearchEmpty()) {
    on<SearchMovieQueryChanged>((event, emit) async {
      final query = event.query;

      if (query.isEmpty) {
        emit(const MovieSearchEmpty());
        return;
      }

      emit(const MovieSearchLoading());

      final result = await searchMovies.execute(query);
      result.fold(
            (failure) => emit(MovieSearchError(failure.message)),
            (data) => emit(MovieSearchHasData(data)),
      );
    }, transformer: _debounce(_duration));
  }
}