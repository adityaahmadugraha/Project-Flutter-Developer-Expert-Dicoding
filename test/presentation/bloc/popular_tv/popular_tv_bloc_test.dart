import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_event.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial state should be Empty', () {
    expect(popularTvBloc.state, const PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularTv()),
    expect: () => [
      const PopularTvLoading(),
      PopularTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetPopularTv.execute()),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularTv()),
    expect: () => [
      const PopularTvLoading(),
      const PopularTvError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetPopularTv.execute()),
  );
}