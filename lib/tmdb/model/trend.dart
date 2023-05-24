
import 'person.dart';
import 'search.dart';

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
