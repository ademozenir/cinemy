
class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.tagline,
    required this.overview,
    required this.genres,
    required this.popularity,
    required this.releaseDate,
    required this.runtime,
    required this.posterPath,
    required this.backdropPath,
    required this.budget,
    required this.revenue,
  });

  final int id;
  final String title;
  final String tagline;
  final String overview;
  final List<Genre> genres;
  final double popularity;
  final String releaseDate;
  final int runtime;
  final String posterPath;
  final String backdropPath;
  final int budget;
  final int revenue;

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map["id"] as int,
      title: map["title"] ?? "",
      tagline: map["tagline"] ?? "",
      overview: map["overview"] ?? "",
      genres: (map["genres"] as List? ?? []).map((e) => Genre.fromJson(e)).toList(),
      popularity: map["popularity"] ?? 0.0,
      releaseDate: map["release_date"] ?? "",
      runtime: map["runtime"] ?? 0,
      posterPath: map["poster_path"] ?? "",
      backdropPath: map["backdrop_path"] ?? "",
      budget: map["budget"] ?? 0,
      revenue: map["revenue"] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, tagline: $tagline, overview: $overview, genres: $genres,'
        ' popularity: $popularity, releaseDate: $releaseDate, runtime: $runtime, posterPath: $posterPath, '
        'backdropPath: $backdropPath, budget: $budget, revenue: $revenue}';
  }

}

class Genre {
  Genre(this.id, this.name);

  final int id;
  final String name;

  factory Genre.fromJson(Map<String, dynamic> map) {
    final id = map["id"] as int;
    final name = map["name"] as String;
    return Genre(id, name);
  }

  @override
  String toString() {
    return 'Genre{id: $id, name: $name}';
  }
}
