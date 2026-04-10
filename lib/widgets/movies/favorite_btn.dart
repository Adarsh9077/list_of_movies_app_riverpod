import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorite/l/favorite_provider.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends ConsumerWidget {
  final MovieModel movieModel;

  const FavoriteBtnWidget({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState =
        ref.watch(favoriteProvider.select((state) => state.favoritesList));
    final isFavorite = favoriteState.any((movie) => movie.id == movieModel.id);
    //     (value) {
    //   return value.favoritesList;
    // }
    // ,
    // ));
    return IconButton(
        onPressed: () {
          // TODO: Implement the favorite logic
          ref
              .read(favoriteProvider.notifier)
              .addOrRemoveFromFavorites(movieModel);
        },
        icon: Icon(
          isFavorite
              ? MyAppIcons.favoriteOutlineRounded
              : MyAppIcons.favoriteRounded,
          color: isFavorite ? Colors.red : Colors.red,
          size: 20,
        ));
  }
}
