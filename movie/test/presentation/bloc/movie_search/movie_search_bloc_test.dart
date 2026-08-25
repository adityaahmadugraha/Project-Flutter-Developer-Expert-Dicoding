import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:core/common/failure.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:movie/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  const tQuery = 'spiderman';

  test('initial state should be Empty', () {
    expect(movieSearchBloc.state, const MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchMovieQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchMovieQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const MovieSearchLoading(),
      const MovieSearchError('Server Failure'),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should emit [Empty] immediately when query is empty, without calling API',
    build: () => movieSearchBloc,
    act: (bloc) => bloc.add(const SearchMovieQueryChanged('')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const MovieSearchEmpty(),
    ],
    verify: (_) => verifyZeroInteractions(mockSearchMovies),
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'should only emit result for the LAST query when typed rapidly (debounce)',
    build: () {
      when(mockSearchMovies.execute('spider'))
          .thenAnswer((_) async => Right(testMovieList));
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return movieSearchBloc;
    },
    act: (bloc) {
      bloc.add(const SearchMovieQueryChanged('spider'));
      bloc.add(const SearchMovieQueryChanged(tQuery));
    },
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const MovieSearchLoading(),
      MovieSearchHasData(testMovieList),
    ],
    verify: (bloc) {
      verifyNever(mockSearchMovies.execute('spider'));
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}