import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvListBloc tvListBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvListBloc = TvListBloc(
      getNowPlayingTv: mockGetNowPlayingTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    );
  });

  test('initial state should be TvListState default', () {
    expect(tvListBloc.state, const TvListState());
  });

  group('Now Playing Tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingTv()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.Loading),
        TvListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTv: testTvList,
        ),
      ],
      verify: (bloc) => verify(mockGetNowPlayingTv.execute()),
    );

    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchNowPlayingTv()),
      expect: () => [
        const TvListState(nowPlayingState: RequestState.Loading),
        const TvListState(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Popular Tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchPopularTv()),
      expect: () => [
        const TvListState(popularTvState: RequestState.Loading),
        TvListState(
          popularTvState: RequestState.Loaded,
          popularTv: testTvList,
        ),
      ],
      verify: (bloc) => verify(mockGetPopularTv.execute()),
    );

    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchPopularTv()),
      expect: () => [
        const TvListState(popularTvState: RequestState.Loading),
        const TvListState(
          popularTvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Top Rated Tv', () {
    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedTv()),
      expect: () => [
        const TvListState(topRatedTvState: RequestState.Loading),
        TvListState(
          topRatedTvState: RequestState.Loaded,
          topRatedTv: testTvList,
        ),
      ],
      verify: (bloc) => verify(mockGetTopRatedTv.execute()),
    );

    blocTest<TvListBloc, TvListState>(
      'should emit [Loading, Error] when data is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(const FetchTopRatedTv()),
      expect: () => [
        const TvListState(topRatedTvState: RequestState.Loading),
        const TvListState(
          topRatedTvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}