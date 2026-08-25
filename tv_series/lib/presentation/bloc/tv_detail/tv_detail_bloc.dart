import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import '../../../domain/usecases/get_tv_detail.dart';
import '../../../domain/usecases/get_tv_recommendations.dart';
import '../../../domain/usecases/get_watchlist_tv_status.dart';
import '../../../domain/usecases/remove_watchlist_tv.dart';
import '../../../domain/usecases/save_watchlist_tv.dart';
import 'tv_detail_event.dart';
import 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchlistTvStatus getWatchlistTvStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchlistTvStatus,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(const TvDetailState()) {
    on<FetchTvDetail>((event, emit) async {
      emit(state.copyWith(tvState: RequestState.Loading));

      final detailResult = await getTvDetail.execute(event.id);
      final recommendationResult = await getTvRecommendations.execute(event.id);

      detailResult.fold(
            (failure) {
          emit(state.copyWith(
            tvState: RequestState.Error,
            message: failure.message,
          ));
        },
            (tv) {
          emit(state.copyWith(
            recommendationState: RequestState.Loading,
            tv: tv,
          ));

          recommendationResult.fold(
                (failure) {
              emit(state.copyWith(
                tvState: RequestState.Loaded,
                tv: tv,
                recommendationState: RequestState.Error,
                message: failure.message,
              ));
            },
                (tvList) {
              emit(state.copyWith(
                tvState: RequestState.Loaded,
                tv: tv,
                recommendationState: RequestState.Loaded,
                tvRecommendations: tvList,
              ));
            },
          );
        },
      );
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final result = await getWatchlistTvStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });

    on<AddWatchlistTv>((event, emit) async {
      final result = await saveWatchlistTv.execute(event.tv);

      String watchlistMessage = '';
      await result.fold(
            (failure) async => watchlistMessage = failure.message,
            (successMessage) async => watchlistMessage = successMessage,
      );

      final status = await getWatchlistTvStatus.execute(event.tv.id);

      emit(state.copyWith(
        watchlistMessage: watchlistMessage,
        isAddedToWatchlist: status,
      ));
    });

    on<RemoveFromWatchlistTv>((event, emit) async {
      final result = await removeWatchlistTv.execute(event.tv);

      String watchlistMessage = '';
      await result.fold(
            (failure) async => watchlistMessage = failure.message,
            (successMessage) async => watchlistMessage = successMessage,
      );

      final status = await getWatchlistTvStatus.execute(event.tv.id);

      emit(state.copyWith(
        watchlistMessage: watchlistMessage,
        isAddedToWatchlist: status,
      ));
    });
  }
}