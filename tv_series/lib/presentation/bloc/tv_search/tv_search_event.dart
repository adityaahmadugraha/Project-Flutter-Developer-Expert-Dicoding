import 'package:equatable/equatable.dart';

sealed class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTvQueryChanged extends TvSearchEvent {
  final String query;
  const SearchTvQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}