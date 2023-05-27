import 'package:bloc/bloc.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';

class TrendingMoviesCubit extends Cubit<MoviesState> {
  TrendingMoviesCubit() : super(MoviesState([]));

  final TMDBService _tmdbService = getIt.get<TMDBService>();

  Future<void> initialPage() async {
    var trendingMovies = await _tmdbService.getTrendingMovies();
    emit(MoviesState(trendingMovies.results));
  }

  void nextPage() {}

  void previousPage() {}
}

class MoviesState {
  List<Movie> movies;

  MoviesState(this.movies);
}
