import 'package:equatable/equatable.dart';

sealed class PopularTvEvent extends Equatable {
  const PopularTvEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTv extends PopularTvEvent {
  const FetchPopularTv();
}