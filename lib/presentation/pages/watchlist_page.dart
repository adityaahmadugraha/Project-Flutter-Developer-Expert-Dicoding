import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_state.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_state.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(const FetchWatchlistMovies());
      context.read<WatchlistTvBloc>().add(const FetchWatchlistTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(const FetchWatchlistMovies());
    context.read<WatchlistTvBloc>().add(const FetchWatchlistTv());
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: kMikadoYellow,
                borderRadius: BorderRadius.circular(24),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white70,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              splashBorderRadius: BorderRadius.circular(24),
              tabs: [Tab(text: 'Movies'), Tab(text: 'TV series')],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
              builder: (context, state) {
                if (state is WatchlistMovieLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WatchlistMovieHasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.result[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.result.length,
                  );
                } else if (state is WatchlistMovieError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(''),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
              builder: (context, state) {
                if (state is WatchlistTvLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WatchlistTvHasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = state.result[index];
                      return TvCard(tv);
                    },
                    itemCount: state.result.length,
                  );
                } else if (state is WatchlistTvError) {
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    key: Key('error_message'),
                    child: Text(''),
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
