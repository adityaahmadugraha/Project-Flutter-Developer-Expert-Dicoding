import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';

sealed class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int id;
  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class LoadWatchlistTvStatus extends TvDetailEvent {
  final int id;
  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlistTv extends TvDetailEvent {
  final TvDetail tv;
  const AddWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlistTv extends TvDetailEvent {
  final TvDetail tv;
  const RemoveFromWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}