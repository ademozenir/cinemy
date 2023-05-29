import 'dart:convert';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/model/person.dart';
import 'package:cinemy/tmdb/model/search.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:http/http.dart';

class TMDBService {
  final _endPoint = "https://api.themoviedb.org/3";
  final _apiKeyParam = "api_key=b8c5342655137883fd9b731dc6f4a920";
  final _imageLink = "https://image.tmdb.org/t/p/w500";

  String imageUrl(String path) {
    return _imageLink + path;
  }

  Future<Movie> getMovie(int id) async {
    Uri uri = Uri.parse("$_endPoint/movie/$id?$_apiKeyParam");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return Movie.fromJson(jsonResponse);
    }
    throw Exception("Could not get movie");
  }

  Future<Person> getPerson(int id) async {
    Uri uri = Uri.parse("$_endPoint/person/$id?$_apiKeyParam");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return Person.fromJson(jsonResponse);
    }
    throw Exception("Could not get person");
  }

  Future<MovieSearch> searchMovie(String title) async {
    Uri uri = Uri.parse("$_endPoint/search/movie?$_apiKeyParam&query=$title");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return MovieSearch.fromJson(jsonResponse);
    }
    throw Exception("Could not search movie");
  }

  Future<PersonSearch> searchPerson(String name) async {
    Uri uri = Uri.parse("$_endPoint/search/person?$_apiKeyParam&query=$name");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return PersonSearch.fromJson(jsonResponse);
    }
    throw Exception("Could not search person");
  }

  Future<MultiSearch> searchMulti(String name) async {
    Uri uri = Uri.parse("$_endPoint/search/multi?$_apiKeyParam&query=$name");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return MultiSearch.fromJson(jsonResponse);
    }
    throw Exception("Could not search multi");
  }

  Future<TrendingMovies> getTrendingMovies(int page) async {
    Uri uri = Uri.parse("$_endPoint/trending/movie/week?$_apiKeyParam&page=$page");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return TrendingMovies.fromJson(jsonResponse);
    }
    throw Exception("Could not get trending movies");
  }

  Future<TrendingPeople> getTrendingPeople() async {
    Uri uri = Uri.parse("$_endPoint/trending/person/week?$_apiKeyParam");
    Response response = await get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return TrendingPeople.fromJson(jsonResponse);
    }
    throw Exception("Could not get trending people");
  }
}
