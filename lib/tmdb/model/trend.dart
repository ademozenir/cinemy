import 'package:cinemy/tmdb/model/movie.dart';
import 'person.dart';
import 'search.dart';

class TrendingMovies extends Page {
  final List<Movie> movies;

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

  TrendingPeople.fromJson(Map<String, dynamic> map)
      : people = (map["results"] as List? ?? []).map((e) => Person.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingPeople{results: $people}';
  }
}
