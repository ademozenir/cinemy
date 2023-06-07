import 'package:cinemy/bloc/trending_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'person_detail_view.dart';

class TrendingPeopleView extends StatefulWidget {
  const TrendingPeopleView({super.key});

  @override
  TrendingPeopleViewState createState() => TrendingPeopleViewState();
}

class TrendingPeopleViewState extends State<TrendingPeopleView> {
  TrendingPeopleViewState() {
    var trendingPeopleCubit = getIt.get<TrendingPeopleCubit>();
    trendingPeopleCubit.nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainSearchBar('Trending People'),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black26,
        ),
        child: BlocBuilder<TrendingPeopleCubit, TrendingPeople>(
            bloc: getIt.get<TrendingPeopleCubit>(),
            builder: (_, state) {
              return TrendingPeopleWidget(peopleState: state);
            }),
      ),
    );
  }
}

class TrendingPeopleWidget extends StatelessWidget {
  TrendingPeopleWidget({required this.peopleState, super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        var trendingMoviesCubit = getIt.get<TrendingPeopleCubit>();
        trendingMoviesCubit.nextPage();
      }
    });
  }

  final TrendingPeople peopleState;
  final TMDBService _tmdbService = getIt.get<TMDBService>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      controller: _scrollController,
      children: peopleState.people
          .map(
            (people) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonDetailView(people.id)),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(_tmdbService.imageUrl(people.profilePath))),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black87)]),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              people.name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ])),
            ),
          )
          .toList(),
    );
  }
}
