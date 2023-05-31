class TvShow {
  TvShow({
    required this.id,
    required this.name,
    required this.mediaType,
    required this.overview,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.posterPath,
    required this.backdropPath,
    required this.voteCount,
  });

  final int id;
  final String name;
  final String mediaType;
  final String overview;
  final double popularity;
  final String firstAirDate;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final int voteCount;

  factory TvShow.fromJson(Map<String, dynamic> map) {
    return TvShow(
      id: map["id"] as int,
      name: map["name"] ?? "",
      mediaType: map["media_type"] ?? "",
      overview: map["overview"] ?? "",
      popularity: map["popularity"] ?? 0.0,
      firstAirDate: map["first_air_date"] ?? "",
      voteAverage: map["vote_average"] ?? 0.0,
      posterPath: map["poster_path"] ?? "",
      backdropPath: map["backdrop_path"] ?? "",
      voteCount: map["vote_count"] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, name: $name, mediaType: $mediaType, overview: $overview, '
        ' popularity: $popularity, firstAirDate: $firstAirDate, voteAverage: $voteAverage, posterPath: $posterPath, '
        'backdropPath: $backdropPath, voteCount: $voteCount,}';
  }
}
