import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvNotifier provider;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    provider = WatchlistTvNotifier(getWatchlistTv: mockGetWatchlistTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('fetch watchlist tv', () {
    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchWatchlistTv();
      // assert
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTv, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
      // act
      await provider.fetchWatchlistTv();
      // assert
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, 'Database Failure');
      expect(listenerCallCount, 2);
    });
  });
}