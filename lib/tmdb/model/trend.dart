import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/model/tv_show.dart';
import 'person.dart';
import 'search.dart';

class TrendingMovies extends Page {
  final List<Movie> movies;

  TrendingMovies(super.page, super.totalPages, super.totalResults, this.movies);

  TrendingMovies.empty()
      : movies = [],
        super.empty();

  TrendingMovies.fromJson(Map<String, dynamic> map)
      : movies = (map["results"] as List? ?? []).map((e) => Movie.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingMovies{results: $movies}';
  }
}

class TrendingPeople extends Page {
  final List<Person> people;

  TrendingPeople(super.page, super.totalPages, super.totalResults, this.people);

  TrendingPeople.empty()
      : people = [],
        super.empty();

  TrendingPeople.fromJson(Map<String, dynamic> map)
      : people = (map["results"] as List? ?? []).map((e) => Person.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingPeople{results: $people}';
  }
}

class TrendingTvShows extends Page {
  final List<TvShow> tvShows;

  TrendingTvShows(super.page, super.totalPages, super.totalResults, this.tvShows);

  TrendingTvShows.empty()
      : tvShows = [],
        super.empty();

  TrendingTvShows.fromJson(Map<String, dynamic> map)
      : tvShows = (map["results"] as List? ?? []).map((e) => TvShow.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingTvShows{results: $tvShows}';
  }
}
