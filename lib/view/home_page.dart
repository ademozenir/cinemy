import 'package:cinemy/bloc/movie_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  HomePageViewState createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  HomePageViewState() {
    var trendingMoviesCubit = getIt.get<TrendingMoviesCubit>();
    trendingMoviesCubit.initialPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black26,
        ),
        child: BlocBuilder<TrendingMoviesCubit, MoviesState>(
            bloc: getIt.get<TrendingMoviesCubit>(),
            builder: (_, state) {
              return TrendingMoviesWidget(moviesState: state);
            }),
      ),
    );
  }
}

class TrendingMoviesWidget extends StatelessWidget {
  TrendingMoviesWidget({required this.moviesState, super.key});

  final MoviesState moviesState;
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: moviesState.movies
          .map((movie) => Card(
                child: Column(
                  children: [
                    Text(movie.title),
                    Text(movie.releaseDate),
                    Image.network(_tmdbService.imageUrl(movie.posterPath))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
