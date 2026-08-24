import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';

import 'top_rated_tv_event.dart';
import 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc(this.getTopRatedTv) : super(const TopRatedTvEmpty()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(const TopRatedTvLoading());

      final result = await getTopRatedTv.execute();
      result.fold(
            (failure) => emit(TopRatedTvError(failure.message)),
            (data) => emit(TopRatedTvHasData(data)),
      );
    });
  }
}