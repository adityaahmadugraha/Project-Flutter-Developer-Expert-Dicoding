import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvNotifier provider;
  late MockGetPopularTv mockGetPopularTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTv = MockGetPopularTv();
    provider = PopularTvNotifier(mockGetPopularTv)
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
    when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchPopularTv();
    // assert
    expect(provider.state, RequestState.Loading);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
    // act
    await provider.fetchPopularTv();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchPopularTv();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}