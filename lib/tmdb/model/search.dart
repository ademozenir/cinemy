import 'package:cinemy/tmdb/model/multi.dart';

import 'movie.dart';
import 'person.dart';

abstract class Page {
  final int page;
  final int totalPages;
  final int totalResults;

  Page.fromJson(Map<String, dynamic> map)
      : page = map["page"] as int,
        totalPages = map["total_pages"] as int,
        totalResults = map["total_results"] as int;
}

class PersonSearch extends Page {
  final List<Person> results;

  PersonSearch.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List).map((e) => Person.fromJson(e)).toList(),
        super.fromJson(map);
}

class MovieSearch extends Page {
  final List<Movie> results;

  MovieSearch.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List).map((e) => Movie.fromJson(e)).toList(),
        super.fromJson(map);
}

class MultiSearch extends Page {
  final List<Multi> results;

  MultiSearch.fromJson(Map<String, dynamic> map)
      : results = (map["results"] as List).map((e) => Multi.fromJson(e)).toList(),
        super.fromJson(map);
}