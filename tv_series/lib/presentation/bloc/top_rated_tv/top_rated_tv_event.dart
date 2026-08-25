import 'package:equatable/equatable.dart';

sealed class TopRatedTvEvent extends Equatable {
  const TopRatedTvEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedTv extends TopRatedTvEvent {
  const FetchTopRatedTv();
}