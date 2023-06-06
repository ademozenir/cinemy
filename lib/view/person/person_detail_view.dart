import 'package:cinemy/bloc/detail_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/person.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailView extends StatelessWidget {
  PersonDetailView(this.personId, {Key? key}) : super(key: key) {
    getIt.get<PersonDetailCubit>().getPerson(personId);
  }

  final int personId;
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDetailCubit, Person>(
      bloc: getIt.get<PersonDetailCubit>(),
      builder: (_, person) {
        return Scaffold(
          appBar: AppBar(
            title: Text(person.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blueGrey[900],
                  child: Column(
                    children: [
                      Image.network(
                        _tmdbService.imageUrl(person.profilePath),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.7,
                        fit: BoxFit.cover,
                      ),
                      PersonInfo(person),
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

class PersonInfo extends StatelessWidget {
  const PersonInfo(this.person, {super.key});

  final Person person;

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
              person.name,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "${person.birthday} | ${person.popularity} | ${person.knownForDepartment}",
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            Text(
              person.biography,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
