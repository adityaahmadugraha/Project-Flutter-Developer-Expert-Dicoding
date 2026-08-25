import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:core/common/state_enum.dart';

import 'tv_list_event.dart';
import 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  TvListBloc({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  }) : super(const TvListState()) {
    on<FetchTvListNowPlaying>((event, emit) async {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));

      final result = await getNowPlayingTv.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          nowPlayingState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTv: data,
        )),
      );
    });

    on<FetchTvListPopular>((event, emit) async {
      emit(state.copyWith(popularTvState: RequestState.Loading));

      final result = await getPopularTv.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          popularTvState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          popularTvState: RequestState.Loaded,
          popularTv: data,
        )),
      );
    });

    on<FetchTvListTopRated>((event, emit) async {
      emit(state.copyWith(topRatedTvState: RequestState.Loading));

      final result = await getTopRatedTv.execute();
      result.fold(
            (failure) => emit(state.copyWith(
          topRatedTvState: RequestState.Error,
          message: failure.message,
        )),
            (data) => emit(state.copyWith(
          topRatedTvState: RequestState.Loaded,
          topRatedTv: data,
        )),
      );
    });
  }
}