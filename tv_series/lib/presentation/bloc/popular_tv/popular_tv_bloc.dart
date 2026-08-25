import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_popular_tv.dart';
import 'popular_tv_event.dart';
import 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc(this.getPopularTv) : super(const PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(const PopularTvLoading());

      final result = await getPopularTv.execute();
      result.fold(
            (failure) => emit(PopularTvError(failure.message)),
            (data) => emit(PopularTvHasData(data)),
      );
    });
  }
}