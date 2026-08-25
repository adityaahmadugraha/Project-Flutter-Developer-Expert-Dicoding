import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/common/failure.dart';

import '../repositories/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
