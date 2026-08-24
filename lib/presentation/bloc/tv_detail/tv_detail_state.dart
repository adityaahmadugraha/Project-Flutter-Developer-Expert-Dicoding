import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

class TvDetailState extends Equatable {
  final RequestState tvState;
  final TvDetail? tv;

  final RequestState recommendationState;
  final List<Tv> tvRecommendations;

  final String message;

  final bool isAddedToWatchlist;
  final String watchlistMessage;

  const TvDetailState({
    this.tvState = RequestState.Empty,
    this.tv,
    this.recommendationState = RequestState.Empty,
    this.tvRecommendations = const [],
    this.message = '',
    this.isAddedToWatchlist = false,
    this.watchlistMessage = '',
  });

  TvDetailState copyWith({
    RequestState? tvState,
    TvDetail? tv,
    RequestState? recommendationState,
    List<Tv>? tvRecommendations,
    String? message,
    bool? isAddedToWatchlist,
    String? watchlistMessage,
  }) {
    return TvDetailState(
      tvState: tvState ?? this.tvState,
      tv: tv ?? this.tv,
      recommendationState: recommendationState ?? this.recommendationState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
    tvState,
    tv,
    recommendationState,
    tvRecommendations,
    message,
    isAddedToWatchlist,
    watchlistMessage,
  ];
}