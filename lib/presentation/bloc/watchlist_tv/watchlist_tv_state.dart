import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

sealed class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {
  const WatchlistTvEmpty();
}

class WatchlistTvLoading extends WatchlistTvState {
  const WatchlistTvLoading();
}

class WatchlistTvError extends WatchlistTvState {
  final String message;
  const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;
  const WatchlistTvHasData(this.result);

  @override
  List<Object> get props => [result];
}