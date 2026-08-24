import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvEmpty extends TopRatedTvState {
  const TopRatedTvEmpty();
}

class TopRatedTvLoading extends TopRatedTvState {
  const TopRatedTvLoading();
}

class TopRatedTvError extends TopRatedTvState {
  final String message;
  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> result;
  const TopRatedTvHasData(this.result);

  @override
  List<Object> get props => [result];
}