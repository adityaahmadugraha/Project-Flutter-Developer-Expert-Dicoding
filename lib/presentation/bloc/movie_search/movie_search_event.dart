import 'package:equatable/equatable.dart';

sealed class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieQueryChanged extends MovieSearchEvent {
  final String query;
  const SearchMovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}