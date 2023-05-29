import 'package:cinemy/bloc/movie_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
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
        child: BlocBuilder<TrendingMoviesCubit, TrendingMovies>(
            bloc: getIt.get<TrendingMoviesCubit>(),
            builder: (_, state) {
              return TrendingMoviesWidget(moviesState: state);
            }),
      ),
    );
  }
}

class TrendingMoviesWidget extends StatelessWidget {
  TrendingMoviesWidget({required this.moviesState, super.key}) {

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
          var trendingMoviesCubit = getIt.get<TrendingMoviesCubit>();
        // Reach the top of the list
        if (_scrollController.position.pixels == 0) {
          trendingMoviesCubit.previousPage();
        }
        // Reach the bottom of the list
        else {
          trendingMoviesCubit.nextPage();
        }
      }
    });
  }

  final TrendingMovies moviesState;
  final TMDBService _tmdbService = getIt.get<TMDBService>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: moviesState.movies
          .map((movie) => Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate),
                    ),
                    Image.network(_tmdbService.imageUrl(movie.backdropPath))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
