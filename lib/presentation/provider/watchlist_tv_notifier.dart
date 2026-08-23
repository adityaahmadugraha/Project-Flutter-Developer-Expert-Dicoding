import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  RequestState _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTv});

  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
          (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}