import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvNotifier provider;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TopRatedTvNotifier(getTopRatedTv: mockGetTopRatedTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    originCountry: ['US'],
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];

  test('initialState should be Empty', () {
    expect(provider.state, equals(RequestState.Empty));
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchTopRatedTv();
    // assert
    expect(provider.state, RequestState.Loading);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await provider.fetchTopRatedTv();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchTopRatedTv();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}