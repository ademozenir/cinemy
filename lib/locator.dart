import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TMDBService>(
    () => TMDBService(),
  );
}
