import 'package:cinemy/tmdb/model/multi.dart';

import 'movie.dart';
import 'person.dart';

abstract class Page {
  final int page;
  final int totalPages;
  final int totalResults;

  Page(this.page, this.totalPages, this.totalResults);

  Page.empty()
      : page = 0,
        totalPages = 0,
        totalResults = 0;

  Page.fromJson(Map<String, dynamic> map)
      : page = map["page"] as int,
        totalPages = map["total_pages"] as int,
        totalResults = map["total_results"] as int;
}

class PersonSearch extends Page {
  final List<Person> people;

  PersonSearch.fromJson(Map<String, dynamic> map)
      : people = (map["results"] as List).map((e) => Person.fromJson(e)).toList(),
        super.fromJson(map);
}

class MovieSearch extends Page {
  final List<Movie> movies;

  MovieSearch.fromJson(Map<String, dynamic> map)
      : movies = (map["results"] as List).map((e) => Movie.fromJson(e)).toList(),
        super.fromJson(map);
}

class MultiSearch extends Page {
  final List<Multi> results;

  MultiSearch.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List).map((e) => Multi.fromJson(e)).toList(),
        super.fromJson(map);
}
