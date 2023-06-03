import 'package:cinemy/bloc/search_cubit.dart';
import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/search.dart';
import 'package:cinemy/view/movie/movie_detail_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.close), onPressed: () => _textController.clear()),
        ],
        title: TextField(
          controller: _textController,
          onChanged: _searchMultiCubit.searh,
        ),
      ),
      body: BlocBuilder<SearchMultiCubit, MultiSearch>(
        bloc: _searchMultiCubit,
        builder: (_, multiSearch) => ListView(
          controller: _scrollController,
          children: multiSearch.results
              .map((multi) => Card(
                    key: Key(multi.id.toString()),
                    child: GestureDetector(
                      onTap: () {
                        if (multi.mediaType == "movie") {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailView(multi.id)));
                        }
                      },
                      child: ListTile(title: Text(multi.name.isNotEmpty ? multi.name : multi.title)),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
