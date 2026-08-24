import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv/now_playing_tv_event.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv/now_playing_tv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvBloc nowPlayingTvBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('initial state should be Empty', () {
    expect(nowPlayingTvBloc.state, const NowPlayingTvEmpty());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingTv()),
    expect: () => [
      const NowPlayingTvLoading(),
      NowPlayingTvHasData(testTvList),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTv.execute()),
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(const FetchNowPlayingTv()),
    expect: () => [
      const NowPlayingTvLoading(),
      const NowPlayingTvError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetNowPlayingTv.execute()),
  );
}