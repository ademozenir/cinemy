import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingMoviesCubit extends Cubit<TrendingMovies> {
  TrendingMoviesCubit() : super(TrendingMovies.empty());

  final TMDBService _tmdbService = getIt.get<TMDBService>();

  Future<void> nextPage() async {
    var trendingMovies = await _tmdbService.getTrendingMovies(state.page + 1);
    state.movies.addAll(trendingMovies.movies);

    emit(
      TrendingMovies(
        trendingMovies.page,
        trendingMovies.totalPages,
        trendingMovies.totalResults,
        state.movies,
      ),
    );
  }
}

class TrendingTvShowsCubit extends Cubit<TrendingTvShows> {
  TrendingTvShowsCubit() : super(TrendingTvShows.empty());

  final TMDBService _tmdbService = getIt.get<TMDBService>();

  Future<void> nextPage() async {
    var trendingTvShows = await _tmdbService.getTrendingTvShows(state.page + 1);
    state.tvShows.addAll(trendingTvShows.tvShows);

    emit(
      TrendingTvShows(
        trendingTvShows.page,
        trendingTvShows.totalPages,
        trendingTvShows.totalResults,
        state.tvShows,
      ),
    );
  }
}

class TrendingPeopleCubit extends Cubit<TrendingPeople> {
  TrendingPeopleCubit() : super(TrendingPeople.empty());

  final TMDBService _tmdbService = getIt.get<TMDBService>();

  Future<void> nextPage() async {
    var trendingPeople = await _tmdbService.getTrendingPeople(state.page + 1);
    state.people.addAll(trendingPeople.people);

    emit(
      TrendingPeople(
        trendingPeople.page,
        trendingPeople.totalPages,
        trendingPeople.totalResults,
        state.people,
      ),
    );
  }
}
