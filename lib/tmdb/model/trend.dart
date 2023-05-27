import 'package:cinemy/tmdb/model/movie.dart';
import 'person.dart';
import 'search.dart';

class TrendingMovies extends Page {
  final List<Movie> results;

  TrendingMovies.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List? ?? []).map((e) => Movie.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingMovies{results: $results}';
  }
}

class TrendingPeople extends Page {
  final List<Person> results;

  TrendingPeople.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List? ?? []).map((e) => Person.fromJson(e)).toList(),
        super.fromJson(map);

  @override
  String toString() {
    return 'TrendingPeople{results: $results}';
  }
}
