import 'package:cinemy/bloc/trending_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/tv_show/tv_show_detail_view.dart';
import 'package:cinemy/view/widget/app_bar.dart';
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
      appBar: MainSearchBar('Trending Tv Shows'),
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
          .map((tvShow) => Card(
                child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TvShowDetailView(tvShow.id)),
                    ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(tvShow.name),
                        subtitle: Text(tvShow.firstAirDate),
                      ),
                      Image.network(_tmdbService.imageUrl(tvShow.posterPath))
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
