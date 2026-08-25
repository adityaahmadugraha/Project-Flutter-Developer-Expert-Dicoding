import 'package:movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchEmpty extends MovieSearchState {
  const MovieSearchEmpty();
}

class MovieSearchLoading extends MovieSearchState {
  const MovieSearchLoading();
}

class MovieSearchError extends MovieSearchState {
  final String message;
  const MovieSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieSearchHasData extends MovieSearchState {
  final List<Movie> result;
  const MovieSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}