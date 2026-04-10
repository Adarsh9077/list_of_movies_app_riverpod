import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/view_models/favorite/l/favorite_provider.dart';

import '../constants/my_app_icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return MoviesWidget(
            movieModel: ,
          ); //const Text("data");
        },
      ),
    );
  }
}
