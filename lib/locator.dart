import 'package:cinemy/bloc/auth_cubit.dart';
import 'package:cinemy/bloc/detail_cubit.dart';
import 'package:cinemy/bloc/search_cubit.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'bloc/trending_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  getIt.registerLazySingleton<TMDBService>(() => TMDBService());

  getIt.registerLazySingleton<YoutubeExplode>(() => YoutubeExplode());

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());

  getIt.registerLazySingleton<TrendingMoviesCubit>(() => TrendingMoviesCubit());

  getIt.registerLazySingleton<TrendingPeopleCubit>(() => TrendingPeopleCubit());

  getIt.registerLazySingleton<TrendingTvShowsCubit>(() => TrendingTvShowsCubit());

  getIt.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit());

  getIt.registerLazySingleton<PersonDetailCubit>(() => PersonDetailCubit());

  getIt.registerLazySingleton<TvShowDetailCubit>(() => TvShowDetailCubit());

  getIt.registerLazySingleton<MovieVideoCubit>(() => MovieVideoCubit());

  getIt.registerLazySingleton<TvShowVideoCubit>(() => TvShowVideoCubit());

  getIt.registerLazySingleton<SearchMultiCubit>(() => SearchMultiCubit());
}
