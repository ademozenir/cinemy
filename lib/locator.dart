import 'package:cinemy/bloc/movie_detail_cubit.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:get_it/get_it.dart';
import 'bloc/trending_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TMDBService>(
    () => TMDBService(),
  );

  getIt.registerLazySingleton<TrendingMoviesCubit>(
    () => TrendingMoviesCubit(),
  );

  getIt.registerLazySingleton<TrendingPeopleCubit>(
    () => TrendingPeopleCubit(),
  );

  getIt.registerLazySingleton<TrendingTvShowsCubit>(
    () => TrendingTvShowsCubit(),
  );

  getIt.registerLazySingleton<MovieDetailCubit>(
    () => MovieDetailCubit(),
  );
}
