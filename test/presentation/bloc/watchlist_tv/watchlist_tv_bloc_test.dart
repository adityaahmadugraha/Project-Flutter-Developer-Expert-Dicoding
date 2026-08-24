import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  test('initial state should be Empty', () {
    expect(watchlistTvBloc.state, const WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistTv()),
    expect: () => [
      const WatchlistTvLoading(),
      WatchlistTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetWatchlistTv.execute()),
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(const FetchWatchlistTv()),
    expect: () => [
      const WatchlistTvLoading(),
      const WatchlistTvError('Database Failure'),
    ],
    verify: (bloc) => verify(mockGetWatchlistTv.execute()),
  );
}