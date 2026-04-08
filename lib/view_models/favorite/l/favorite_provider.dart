import 'package:flutter_riverpod/legacy.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorite/l/favorite_state.dart';

class FavoriteProvider extends StateNotifier<FavoriteState> {
  FavoriteProvider() : super(FavoriteState());
  final favKey = "favKey";

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MovieModel movieModel) async {
    if (isFavorite(movieModel)) {
      state.favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    } else {
      state.copyWith().favoritesList.add(movieModel);
    }
    //! await saveFavorite();
    //? 76.  4:44
  }
}
