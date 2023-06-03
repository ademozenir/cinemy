import 'package:cinemy/bloc/movie_detail_cubit.dart';
import 'package:cinemy/bloc/search_cubit.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'bloc/trending_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TMDBService>(
    () => TMDBService(),
  );

  getIt.registerLazySingleton<YoutubeExplode>(
    () => YoutubeExplode(),
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

  getIt.registerLazySingleton<MovieVideoCubit>(
    () => MovieVideoCubit(),
  );

  getIt.registerLazySingleton<SearchMultiCubit>(
    () => SearchMultiCubit(),
  );

}
