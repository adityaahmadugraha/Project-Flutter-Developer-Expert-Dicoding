import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';

import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repository;
  SearchTv(this.repository);
  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}