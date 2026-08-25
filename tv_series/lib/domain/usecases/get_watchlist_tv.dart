import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchlistTv {
  final TvRepository repository;
  GetWatchlistTv(this.repository);
  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getWatchlistTv();
  }
}