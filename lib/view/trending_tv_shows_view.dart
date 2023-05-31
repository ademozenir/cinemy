import 'package:cinemy/bloc/trending_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TrendingTvShowsView extends StatefulWidget {
  const TrendingTvShowsView({super.key});

  @override
  TrendingTvShowsViewState createState() => TrendingTvShowsViewState();
}

class TrendingTvShowsViewState extends State<TrendingTvShowsView> {
  TrendingTvShowsViewState() {
    var trendingTvShowsCubit = getIt.get<TrendingTvShowsCubit>();
    trendingTvShowsCubit.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Tv Shows'),
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
        child: BlocBuilder<TrendingTvShowsCubit, TrendingTvShows>(
            bloc: getIt.get<TrendingTvShowsCubit>(),
            builder: (_, state) {
              return TrendingTvShowWidget(tvShowsState: state);
            }),
      ),
    );
  }
}

class TrendingTvShowWidget extends StatelessWidget {
  TrendingTvShowWidget({required this.tvShowsState, super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        var trendingTvShowsCubit = getIt.get<TrendingTvShowsCubit>();
        trendingTvShowsCubit.nextPage();
      }
    });
  }

  final TrendingTvShows tvShowsState;
  final TMDBService _tmdbService = getIt.get<TMDBService>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: tvShowsState.tvShows
          .map((people) => Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(people.name),
                      subtitle: Text(people.firstAirDate),
                    ),
                    Image.network(_tmdbService.imageUrl(people.backdropPath))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
