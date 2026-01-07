import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';
import 'package:riverpod/legacy.dart';

class FavoriteProvider extends StateNotifier<FavoritesState>{
  FavoriteProvider():super(FavoritesState(favoritesList: []));
}