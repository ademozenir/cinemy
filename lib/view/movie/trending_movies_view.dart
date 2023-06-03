import 'package:cinemy/bloc/trending_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/movie/movie_detail_view.dart';
import 'package:cinemy/view/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingMoviesView extends StatefulWidget {
  const TrendingMoviesView({super.key});

  @override
  TrendingMoviesViewState createState() => TrendingMoviesViewState();
}

class TrendingMoviesViewState extends State<TrendingMoviesView> {
  TrendingMoviesViewState() {
    var trendingMoviesCubit = getIt.get<TrendingMoviesCubit>();
    trendingMoviesCubit.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));
            },
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
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        var trendingMoviesCubit = getIt.get<TrendingMoviesCubit>();
        trendingMoviesCubit.nextPage();
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
          .map(
            (movie) => Card(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailView(movie.id)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      subtitle: Text(movie.releaseDate),
                      title: Text(movie.title),
                    ),
                    Image.network(_tmdbService.imageUrl(movie.backdropPath))
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
