import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv.dart';

import 'now_playing_tv_event.dart';
import 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv getNowPlayingTv;

  NowPlayingTvBloc(this.getNowPlayingTv) : super(const NowPlayingTvEmpty()) {
    on<FetchNowPlayingTv>((event, emit) async {
      emit(const NowPlayingTvLoading());

      final result = await getNowPlayingTv.execute();
      result.fold(
            (failure) => emit(NowPlayingTvError(failure.message)),
            (data) => emit(NowPlayingTvHasData(data)),
      );
    });
  }
}