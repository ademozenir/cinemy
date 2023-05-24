
class Multi {
  Multi({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
    required this.movie,
    required this.popularity,
    required this.releaseDate,
  });

  final int id;
  final String title;
  final String backdropPath;
  final String overview;
  final String posterPath;
  final String movie;
  final double popularity;
  final String releaseDate;

  factory Multi.fromJson(Map<String, dynamic> map) {
    return Multi(
      id: map["id"] as int,
      title: map["title"] ?? "",
      backdropPath: map["backdrop_path"] ?? "",
      overview: map["overview"] ?? "",
      posterPath: map["poster_path"] ?? "",
      movie: map["movie"] ?? "",
      popularity: map["popularity"] ?? 0.0,
      releaseDate: map["poster_path"] ?? "",
    );
  }

  @override
  String toString() {
    return 'Multi{id: $id, title: $title, backdropPath: $backdropPath, overview: $overview, '
        'posterPath: $posterPath, movie: $movie, popularity: $popularity, releaseDate: $releaseDate}';
  }
}
