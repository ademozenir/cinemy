import 'package:cinemy/locator.dart';
import 'package:cinemy/tmdb/model/search.dart';
import 'package:cinemy/tmdb/tmdb_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMultiCubit extends Cubit<MultiSearch> {
  SearchMultiCubit() : super(MultiSearch.empty());

  final TMDBService _tmdbService = getIt.get<TMDBService>();
  String _name = "";

  Future<void> searh(String name) async {
    _name = name;
    var multiSearch = await _tmdbService.searchMulti(name);
    emit(multiSearch);
  }

  Future<void> nextPage() async {
    var multiSearch = await _tmdbService.searchMulti(_name, state.page + 1);
    state.results.addAll(multiSearch.results);

    emit(
      MultiSearch(
        state.results,
        multiSearch.page,
        multiSearch.totalPages,
        multiSearch.totalResults,
      ),
    );
  }
}
