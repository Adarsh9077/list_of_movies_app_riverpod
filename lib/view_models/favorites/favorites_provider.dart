import 'dart:convert';

import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_state.dart';
import 'package:riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends StateNotifier<FavoritesState> {
  FavoriteProvider() : super(FavoritesState(favoritesList: []));
  final favKey = "fav_key";

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFromFavorite(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      state.favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      state.favoritesList.add(movieModel);
    }
  }

  Future saveFavorite() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = state.favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    pref.setStringList(favKey, stringList);
  }

  Future<void> loadFavorite() async {
    final pref = await SharedPreferences.getInstance();
    final stringList = pref.getStringList(favKey) ?? [];
    state.favoritesList.clear();
    state.favoritesList.addAll(
        stringList.map((movie) => MovieModel.fromJson(jsonDecode(movie))));
  }

  void clearAllFav() {
    state.favoritesList.clear();
    saveFavorite();
  }
}
