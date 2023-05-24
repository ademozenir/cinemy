
class Person {
  Person({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthday,
    required this.placeOfBirth,
    required this.deathday,
    required this.gender,
    required this.knownForDepartment,
    required this.popularity,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String biography;
  final String birthday;
  final String placeOfBirth;
  final String deathday;
  final int gender;
  final String knownForDepartment;
  final double popularity;
  final String profilePath;

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      id: map["id"] as int,
      name: map["name"] as String,
      biography: map["biography"] ?? "",
      birthday: map["birthday"] ?? "",
      placeOfBirth: map["place_of_birth"] ?? "",
      deathday: map["deathday"] ?? "",
      gender: map["gender"] as int,
      knownForDepartment: map["known_for_department"] as String,
      popularity: map["popularity"] as double,
      profilePath: map["profile_path"] ?? "",
    );
  }

  @override
  String toString() {
    return 'Person{id: $id, name: $name, biography: $biography, birthday: $birthday,'
        ' placeOfBirth: $placeOfBirth, deathday: $deathday, gender: $gender,'
        ' knownForDepartment: $knownForDepartment, popularity: $popularity, profilePath: $profilePath}';
  }
}
