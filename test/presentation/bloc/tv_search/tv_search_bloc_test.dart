import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_search/tv_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(searchTv: mockSearchTv);
  });

  const tQuery = 'Game of Thrones';

  test('initial state should be Empty', () {
    expect(tvSearchBloc.state, const TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const TvSearchLoading(),
      TvSearchHasData(testTvList),
    ],
    verify: (bloc) => verify(mockSearchTv.execute(tQuery)),
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const SearchTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const TvSearchLoading(),
      const TvSearchError('Server Failure'),
    ],
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Empty] immediately when query is empty, without calling API',
    build: () => tvSearchBloc,
    act: (bloc) => bloc.add(const SearchTvQueryChanged('')),
    wait: const Duration(milliseconds: 600),
    expect: () => [
      const TvSearchEmpty(),
    ],
    verify: (_) => verifyZeroInteractions(mockSearchTv),
  );
}