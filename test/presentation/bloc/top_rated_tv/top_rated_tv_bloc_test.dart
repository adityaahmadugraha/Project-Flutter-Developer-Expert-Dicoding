import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be Empty', () {
    expect(topRatedTvBloc.state, const TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedTv()),
    expect: () => [
      const TopRatedTvLoading(),
      TopRatedTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetTopRatedTv.execute()),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedTv()),
    expect: () => [
      const TopRatedTvLoading(),
      const TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetTopRatedTv.execute()),
  );
}
