import 'package:cinemy/bloc/detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/tv_show.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/video/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class TvShowDetailView extends StatelessWidget {
  TvShowDetailView(this.tvShow, {Key? key}) : super(key: key) {
    getIt.get<TvShowDetailCubit>().getTvShow(tvShow);
  }

  final int tvShow;
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailCubit, TvShow>(
      bloc: getIt.get<TvShowDetailCubit>(),
      builder: (_, tvShow) {
        return Scaffold(
                 backgroundColor: Colors.blueGrey[900],
          appBar: AppBar(
            title: Text(tvShow.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blueGrey[900],
                  child: Column(
                    children: [
                      Image.network(
                        _tmdbService.imageUrl(tvShow.posterPath),
                        fit: BoxFit.cover,
                      ),
                      TvShowInfo(tvShow),
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

class TvShowInfo extends StatelessWidget {
  const TvShowInfo(this.tvShow, {super.key});

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              tvShow.name,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${tvShow.firstAirDate} | ${tvShow.popularity} ",
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
                initialRating: tvShow.voteAverage / 2,
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
              tvShow.overview,
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
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                          fixedSize: Size(MediaQuery.of(context).size.width * 0.400, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        var tvShowVideoCubit = getIt.get<TvShowVideoCubit>();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => VideoView(tvShow.id, tvShowVideoCubit)));
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
