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
    return ListView(
      controller: _scrollController,
      children: peopleState.people
          .map((people) => Card(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonDetailView(people.id)),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(people.name),
                        subtitle: Text(people.knownForDepartment),
                      ),
                      Image.network(_tmdbService.imageUrl(people.profilePath))
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
