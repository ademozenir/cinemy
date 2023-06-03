import 'package:cinemy/bloc/movie_detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/movie/trailer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailView extends StatelessWidget {
  MovieDetailView(this.movieId, {Key? key}) : super(key: key) {
    getIt.get<MovieDetailCubit>().getMovie(movieId);
  }

  final int movieId;
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, Movie>(
      bloc: getIt.get<MovieDetailCubit>(),
      builder: (_, movie) {
        return Scaffold(
          appBar: AppBar(
            title: Text(movie.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: const Color(0xFF000B49),
                  child: Column(
                    children: [
                      Image.network(
                        _tmdbService.imageUrl(movie.posterPath),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        fit: BoxFit.cover,
                      ),
                      MovieInfo(movie),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MovieInfo extends StatelessWidget {
  const MovieInfo(this.movie, {super.key});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${movie.releaseDate} | ${movie.genres.fold("", (previousValue, genre) => "$previousValue ${genre.name}")} | ${movie.runtime}",
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
                initialRating: movie.voteAverage / 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 20,
                unratedColor: Colors.white,
                itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {}),
            const SizedBox(height: 25),
            Text(
              movie.overview,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.pink[900],
                          fixedSize: Size(MediaQuery.of(context).size.width * 0.400, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () {},
                      child: RichText(
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                            children: [
                              TextSpan(
                                text: "Add to",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                              ),
                              const TextSpan(
                                text: " Watchlist",
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                          fixedSize: Size(MediaQuery.of(context).size.width * 0.400, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => TrailerView(movie.id)));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Start Watching",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
