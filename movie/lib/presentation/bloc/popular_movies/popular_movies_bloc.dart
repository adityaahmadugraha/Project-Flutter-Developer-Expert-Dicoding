import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import 'popular_movies_event.dart';
import 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc(this.getPopularMovies) : super(const PopularMoviesEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(const PopularMoviesLoading());

      final result = await getPopularMovies.execute();
      result.fold(
            (failure) => emit(PopularMoviesError(failure.message)),
            (data) => emit(PopularMoviesHasData(data)),
      );
    });
  }
}