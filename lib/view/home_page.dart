import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/movie.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  HomePageViewState createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  final TMDBService _tmdbService = getIt.get<TMDBService>();
  Movie? _movie;
  Widget _searchBar = const Text('Movies');
  Icon _visibleIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
        actions: <Widget>[
          IconButton(
            icon: _visibleIcon,
            onPressed: () {
              setState(() {
                if (this._visibleIcon.icon == Icons.search) {
                  this._visibleIcon = Icon(Icons.cancel);
                  this._searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (String text) async {
                      int id = int.parse(text);
                      Movie movie = await _tmdbService.getMovie(id);
                      this._movie = movie;
                    },
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  setState(() {
                    this._visibleIcon = Icon(Icons.search);
                    this._searchBar = Text('Movies');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: _movie != null
            ? Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_movie!.title, style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 8),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image.network(_tmdbService.imageUrl(_movie!.posterPath)),
                        ),
                        const SizedBox(height: 8),
                        Text(_movie!.overview),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: Text("The movie not load yet")),
      ),
    );
  }
}
