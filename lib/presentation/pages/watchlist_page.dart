import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration(milliseconds: 400),
    );
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTv();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTv();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: kMikadoYellow,
            borderRadius: BorderRadius.circular(24),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          splashBorderRadius: BorderRadius.circular(24),
          tabs: [Tab(text: 'Movies'), Tab(text: 'TV series')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistMovieNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = data.watchlistMovies[index];
                      return MovieCard(movie);
                    },
                    itemCount: data.watchlistMovies.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<WatchlistTvNotifier>(
              builder: (context, data, child) {
                if (data.watchlistState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.watchlistState == RequestState.Loaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.watchlistTv[index];
                      return TvCard(tv);
                    },
                    itemCount: data.watchlistTv.length,
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(data.message),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}