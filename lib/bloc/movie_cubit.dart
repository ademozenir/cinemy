import 'package:bloc/bloc.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';

class TrendingMoviesCubit extends Cubit<TrendingMovies> {
  TrendingMoviesCubit() : super(TrendingMovies.empty());

  final TMDBService _tmdbService = getIt.get<TMDBService>();

  Future<void> initialPage() async {
    var trendingMovies = await _tmdbService.getTrendingMovies(1);
    emit(trendingMovies);
  }

  Future<void> nextPage() async {
    var trendingMovies = await _tmdbService.getTrendingMovies(state.page + 1);
    emit(trendingMovies);
  }

  Future<void> previousPage() async {
    var trendingMovies = await _tmdbService.getTrendingMovies(state.page - 1);
    emit(trendingMovies);
  }
}
