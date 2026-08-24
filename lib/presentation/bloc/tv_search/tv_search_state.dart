import 'package:ditonton/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

sealed class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class TvSearchEmpty extends TvSearchState {
  const TvSearchEmpty();
}

class TvSearchLoading extends TvSearchState {
  const TvSearchLoading();
}

class TvSearchError extends TvSearchState {
  final String message;
  const TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSearchHasData extends TvSearchState {
  final List<Tv> result;
  const TvSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}