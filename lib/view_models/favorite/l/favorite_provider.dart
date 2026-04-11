import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorite/l/favorite_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteProvider, FavoriteState>((ref) {
  return FavoriteProvider();
});

class FavoriteProvider extends StateNotifier<FavoriteState> {
  FavoriteProvider() : super(FavoriteState());
  final favKey = "favKey";

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MovieModel movieModel) async {
    final wasFavorite = isFavorite(movieModel);
    List<MovieModel> updateFavorite = wasFavorite
        ? state.favoritesList
            .where((element) => element.id != movieModel.id)
            .toList()
        : [...state.favoritesList, movieModel];
    state = state.copyWith(favoritesList: updateFavorite);
    //!
    // if (isFavorite(movieModel)) {
    //   state.favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    // } else {
    //   state.copyWith().favoritesList.add(movieModel);
    // }
    await saveFavorite();
  }

  Future<void> saveFavorite() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = state.favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    pref.setStringList(favKey, stringList);
  }

  Future<void> loadFavorites() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = pref.getStringList(favKey) ?? [];
    final movies = stringList
        .map((movie) => MovieModel.fromJson(jsonDecode(movie)))
        .toList();
    state = state.copyWith(favoritesList: movies);
    // state.favoritesList.clear();
    // state.favoritesList.addAll(
    //     stringList.map((movie) => MovieModel.fromJson(json.decode(movie))));
  }

  Future<void> clearAll() async {
    state = state.copyWith(favoritesList: []);

    saveFavorite();
  }
}
