import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_watchlist_tv.dart';
import 'watchlist_tv_event.dart';
import 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvBloc({required this.getWatchlistTv})
      : super(const WatchlistTvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(const WatchlistTvLoading());

      final result = await getWatchlistTv.execute();
      result.fold(
            (failure) => emit(WatchlistTvError(failure.message)),
            (data) => emit(WatchlistTvHasData(data)),
      );
    });
  }
}