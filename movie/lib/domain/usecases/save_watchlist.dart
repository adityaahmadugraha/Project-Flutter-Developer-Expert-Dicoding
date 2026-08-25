import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../../../movie/lib/domain/entities/movie_detail.dart';
import '../../../movie/lib/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
