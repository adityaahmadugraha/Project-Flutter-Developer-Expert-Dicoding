import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late TvDetailBloc tvDetailBloc;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchlistTvStatus: mockGetWatchlistTvStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
  });

  final tId = 1;

  test('initial state should be TvDetailState default', () {
    expect(tvDetailBloc.state, const TvDetailState());
  });

  group('Fetch Tv Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, intermediate, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        TvDetailState(
          tvState: RequestState.Loading,
          tv: testTvDetail,
          recommendationState: RequestState.Loading,
        ),
        TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: testTvList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Error] when getting detail is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        const TvDetailState(
          tvState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit recommendationState Error when recommendations fail',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(FetchTvDetail(tId)),
      expect: () => [
        const TvDetailState(tvState: RequestState.Loading),
        TvDetailState(
          tvState: RequestState.Loading,
          tv: testTvDetail,
          recommendationState: RequestState.Loading,
        ),
        TvDetailState(
          tvState: RequestState.Loaded,
          tv: testTvDetail,
          recommendationState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });

  group('Watchlist Status', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit isAddedToWatchlist true when status is true',
      build: () {
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTvStatus(tId)),
      expect: () => [
        const TvDetailState(isAddedToWatchlist: true),
      ],
    );
  });

  group('Add Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit watchlistMessage and isAddedToWatchlist true on success',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(testTvDetail.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit failure message when add watchlist failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Failed',
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('Remove Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit watchlistMessage and isAddedToWatchlist false on success',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        verify(mockGetWatchlistTvStatus.execute(testTvDetail.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit failure message when remove watchlist failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistTvStatus.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
      expect: () => [
        const TvDetailState(
          watchlistMessage: 'Failed',
          isAddedToWatchlist: true,
        ),
      ],
    );
  });
}