import 'package:equatable/equatable.dart';

sealed class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedMovies extends TopRatedMoviesEvent {
  const FetchTopRatedMovies();
}