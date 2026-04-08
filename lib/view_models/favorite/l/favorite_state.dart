import 'package:mvvm_statemanagements/models/movies_model.dart';

class FavoriteState {
  final List<MovieModel> favoritesList;

  FavoriteState({this.favoritesList = const []});

  FavoriteState copyWith({
    List<MovieModel>? favoritesList,
  }) {
    return FavoriteState(favoritesList: favoritesList ?? this.favoritesList);
  }
}
