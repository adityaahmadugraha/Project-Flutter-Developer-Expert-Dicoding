import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../domain/usecases/search_tv.dart';
import 'tv_search_event.dart';
import 'tv_search_state.dart';

const _duration = Duration(milliseconds: 500);

EventTransformer<Event> _debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv searchTv;

  TvSearchBloc({required this.searchTv}) : super(const TvSearchEmpty()) {
    on<SearchTvQueryChanged>((event, emit) async {
      final query = event.query;

      if (query.isEmpty) {
        emit(const TvSearchEmpty());
        return;
      }

      emit(const TvSearchLoading());

      final result = await searchTv.execute(query);
      result.fold(
            (failure) => emit(TvSearchError(failure.message)),
            (data) => emit(TvSearchHasData(data)),
      );
    }, transformer: _debounce(_duration));
  }
}