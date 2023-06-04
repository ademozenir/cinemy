import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/model/movie_video.dart';
import 'package:cinemy/tmdb/model/person.dart';
import 'package:cinemy/tmdb/model/tv_show.dart';
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

abstract class VideoCubit extends Cubit<List<Video>> {
  VideoCubit() : super([]);

  void getVideos(int id);
}

class MovieVideoCubit extends VideoCubit {
  final _tmdbService = getIt.get<TMDBService>();

  @override
  Future<void> getVideos(int id) async {
    var videos = await _tmdbService.getMovieVideos(id);
    emit(videos);
  }
}

class PersonDetailCubit extends Cubit<Person> {
  PersonDetailCubit() : super(Person.empty());

  final _tmdbService = getIt.get<TMDBService>();

  Future<void> getPerson(int id) async {
    var person = await _tmdbService.getPerson(id);
    emit(person);
  }
}

class TvShowDetailCubit extends Cubit<TvShow> {
  TvShowDetailCubit() : super(TvShow.empty());

  final _tmdbService = getIt.get<TMDBService>();

  Future<void> getTvShow(int id) async {
    var tvShow = await _tmdbService.getTvShow(id);
    emit(tvShow);
  }
}

class TvShowVideoCubit extends VideoCubit {
  final _tmdbService = getIt.get<TMDBService>();

  @override
  Future<void> getVideos(int id) async {
    var videos = await _tmdbService.getTvShowVideos(id);
    emit(videos);
  }
}
