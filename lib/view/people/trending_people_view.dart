import 'package:cinemy/bloc/trending_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/trend.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        title: const Text('Trending People'),
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
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(people.name),
              subtitle: Text(people.knownForDepartment),
            ),
            Image.network(_tmdbService.imageUrl(people.profilePath))
          ],
        ),
      ))
          .toList(),
    );
  }
}
