import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/widgets/media_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/sub_heading.dart';
import 'now_playing_movies_page.dart';
import 'now_playing_tv_page.dart';

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
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();
      Provider.of<TvListNotifier>(context, listen: false)
        ..fetchNowPlayingTv()
        ..fetchPopularTv()
        ..fetchTopRatedTv();
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
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: kMikadoYellow,
            borderRadius: BorderRadius.circular(24),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 4,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          splashBorderRadius: BorderRadius.circular(24),
          tabs: [
            Tab(text: 'Movies'),
            Tab(text: 'TV series'),
          ],
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
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildSubHeading(
              title: 'Now Playing',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME),
            ),
            Consumer<MovieListNotifier>(
              builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.nowPlayingMovies);
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
            Consumer<MovieListNotifier>(
              builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            Consumer<MovieListNotifier>(
              builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.topRatedMovies);
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class _TvHomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'On The Air',
              onTap: () =>
                  Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(
              builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return TvList(data.nowPlayingTv);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(
              builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return TvList(data.popularTv);
                } else {
                  return Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
            ),
            Consumer<TvListNotifier>(
              builder: (context, data, child) {
                final state = data.topRatedTvState;
                if (state == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return TvList(data.topRatedTv);
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
