import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [18, 10759],
  id: 1399,
  originalName: 'Game of Thrones',
  overview:
  'Seven noble families fight for control of the mythical land of Westeros.',
  popularity: 369.594,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  firstAirDate: '2011-04-17',
  name: 'Game of Thrones',
  originCountry: ['US'],
  voteAverage: 8.4,
  voteCount: 11504,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  numberOfSeasons: 3,
  numberOfEpisodes: 24,
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};