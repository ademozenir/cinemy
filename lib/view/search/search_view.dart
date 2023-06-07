import 'package:cinemy/bloc/search_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/search.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:cinemy/view/movie/movie_detail_view.dart';
import 'package:cinemy/view/person/person_detail_view.dart';
import 'package:cinemy/view/tv_show/tv_show_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _searchMultiCubit.nextPage();
      }
    });
  }

  final _textController = TextEditingController();
  final _searchMultiCubit = getIt.get<SearchMultiCubit>();
  final _scrollController = ScrollController();
  final TMDBService _tmdbService = getIt.get<TMDBService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: SizedBox(
            width: 310,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 5),
              child: TextField(
                controller: _textController,
                onChanged: _searchMultiCubit.searh,
                decoration: InputDecoration(
                  isCollapsed: false,
                  fillColor: Colors.white70,filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _textController.clear(),
                  ),
                ),
              ),
            ),
          ),
        ),

      body: BlocBuilder<SearchMultiCubit, MultiSearch>(
        bloc: _searchMultiCubit,
        builder: (_, multiSearch) => GridView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),
          controller: _scrollController,
          children: multiSearch.results
              .map(
                (multi) => Container(
                  color: Colors.blueGrey[900],
                  key: Key(multi.id.toString()),
                  child: GestureDetector(
                    onTap: () {
                      Widget view = switch (multi.mediaType) {
                        "movie" => MovieDetailView(multi.id),
                        "person" => PersonDetailView(multi.id),
                        _ => TvShowDetailView(multi.id)
                      };
                      Navigator.push(context, MaterialPageRoute(builder: (context) => view));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_tmdbService
                              .imageUrl(multi.backdropPath.isNotEmpty ? multi.backdropPath : multi.profilePath)),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black54)]),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                multi.name.isNotEmpty ? multi.name : multi.title,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
