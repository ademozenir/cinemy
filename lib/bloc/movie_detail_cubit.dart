import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/model/movie_video.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailCubit extends Cubit<Movie> {
  MovieDetailCubit() : super(Movie.empty());

  final _tmdbService = getIt.get<TMDBService>();

  Future<void> getMovie(int id) async {
    var movie = await _tmdbService.getMovie(id);
    emit(movie);
  }
}

class MovieVideoCubit extends Cubit<List<Video>> {
  MovieVideoCubit() : super([]);

  final _tmdbService = getIt.get<TMDBService>();

  Future<void> getMovieVideos(int id) async {
    var videos = await _tmdbService.getMovieVideos(id);
    emit(videos);
  }
}


