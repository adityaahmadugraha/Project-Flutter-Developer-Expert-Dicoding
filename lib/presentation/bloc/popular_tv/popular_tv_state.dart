import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

sealed class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvEmpty extends PopularTvState {
  const PopularTvEmpty();
}

class PopularTvLoading extends PopularTvState {
  const PopularTvLoading();
}

class PopularTvError extends PopularTvState {
  final String message;
  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHasData extends PopularTvState {
  final List<Tv> result;
  const PopularTvHasData(this.result);

  @override
  List<Object> get props => [result];
}