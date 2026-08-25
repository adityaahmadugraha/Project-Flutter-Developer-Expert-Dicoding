import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/common/failure.dart';

import '../repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}


