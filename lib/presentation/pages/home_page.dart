import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_state.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_state.dart';
import 'package:ditonton/presentation/pages/now_playing_movies_page.dart';
import 'package:ditonton/presentation/pages/now_playing_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/widgets/media_list_widgets.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: Duration(milliseconds: 400),
    );
    _tabController.addListener(() => setState(() {}));

    Future.microtask(() {
      context.read<MovieListBloc>()
        ..add(const FetchNowPlayingMovies())
        ..add(const FetchPopularMovies())
        ..add(const FetchTopRatedMovies());
      context.read<TvListBloc>()
        ..add(const FetchNowPlayingTv())
        ..add(const FetchPopularTv())
        ..add(const FetchTopRatedTv());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              if (_tabController.index == 0) {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
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
              indicatorPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
        children: [_MovieHomeTab(), _TvHomeTab()],
      ),
    );
  }
}

class _MovieHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeading(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state.nowPlayingState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.nowPlayingState == RequestState.Loaded) {
                  return MovieList(state.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state.popularMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.popularMoviesState == RequestState.Loaded) {
                  return MovieList(state.popularMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state.topRatedMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.topRatedMoviesState == RequestState.Loaded) {
                  return MovieList(state.topRatedMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TvHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubHeading(
              title: 'On The Air',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                if (state.nowPlayingState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.nowPlayingState == RequestState.Loaded) {
                  return TvList(state.nowPlayingTv);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                if (state.popularTvState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.popularTvState == RequestState.Loaded) {
                  return TvList(state.popularTv);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
            ),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (context, state) {
                if (state.topRatedTvState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.topRatedTvState == RequestState.Loaded) {
                  return TvList(state.topRatedTv);
                } else {
                  return Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}