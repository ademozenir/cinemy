import 'package:cinemy/bloc/detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/comment/comment_view.dart';
import 'package:cinemy/view/video/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailView extends StatelessWidget {
  MovieDetailView(this._movieId, {Key? key}) : super(key: key) {
    getIt.get<MovieDetailCubit>().getMovie(_movieId);
  }

  final int _movieId;
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, Movie>(
      bloc: getIt.get<MovieDetailCubit>(),
      builder: (_, movie) {
        return Scaffold(
          backgroundColor: Colors.blueGrey[900],
          appBar: AppBar(
            title: Text(movie.title),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blueGrey[900],
                  child: Column(
                    children: [
                      Image.network(
                        _tmdbService.imageUrl(movie.posterPath),
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
  const MovieInfo(this._movie, {super.key});

  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Positioned(
          bottom: 15,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  _movie.title,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  "${_movie.releaseDate} | ${_movie.genres.fold("", (previousValue, genre) => "$previousValue ${genre.name}")} | ${_movie.runtime}",
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                    initialRating: _movie.voteAverage / 2,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: 20,
                    unratedColor: Colors.white,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {}),
                const SizedBox(height: 25),
                Text(
                  _movie.overview,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
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
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.pink[900],
                              fixedSize: Size(MediaQuery.of(context).size.width * 0.400, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentView(
                                          "movie:${_movie.id}",
                                          _movie.title,
                                        )));
                          },
                          child: RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "Comments",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                                  ),
                                ]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.white,
                              fixedSize: Size(MediaQuery.of(context).size.width * 0.400, 60),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            var movieVideoCubit = getIt.get<MovieVideoCubit>();
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => VideoView(_movie.id, movieVideoCubit)));
                          },
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Trailers",
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
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
        ),
      ],
    );
  }
}
