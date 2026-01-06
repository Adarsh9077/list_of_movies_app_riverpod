import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/service/api_service.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';

import '../constants/my_app_icons.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';
import 'favorites_screen.dart';

class MoviesScreen extends ConsumerWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Popular Movies"),
          actions: [
            IconButton(
              onPressed: () {
                // getIt<NavigationService>().showSnackbar();
                // getIt<NavigationService>().showDialog(MoviesWidget());
                getIt<NavigationService>().navigate(const FavoritesScreen());
              },
              icon: const Icon(
                MyAppIcons.favoriteRounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () async {
                // final List<MovieModel> movies = await getIt<ApiService>().fetchMovies();
                // print("movies $movies");
                // final List<MoviesGenre> genres =
                //     await getIt<MoviesRepository>().fetchGenres();
                // await getIt<ApiService>().fetchGenres();

                // log("Genres are $genres");
                await ref.read(themeProvider.notifier).toggleTheme();
                print("message");
              },
              icon: Icon(
                themeState == ThemeEnums.light
                    ? MyAppIcons.darkMode
                    : MyAppIcons.lightMode,
              ),
            ),
          ],
        ),
        body: Consumer(
          builder: (context, WidgetRef ref, child) {
            // ref.read(moviesProvider.notifier).getMovies();
            final movieState = ref.watch(moviesProvider);

            print(movieState.moviesList.length);
            if (movieState.isLoading && movieState.moviesList.isEmpty) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (movieState.fetchMoviesError.isNotEmpty) {
              return Center(
                child: Text(movieState.fetchMoviesError),
              );
            }
            return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollinfo) {
                  if (scrollinfo.metrics.pixels >=
                          scrollinfo.metrics.maxScrollExtent - 100 &&
                      !movieState.isLoading) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(moviesProvider.notifier).getMovies();
                    });
                    // return true;
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: movieState.moviesList.length,
                  itemBuilder: (context, index) {
                    print("object Ram Ram ${movieState.moviesList.length}");
                    return MoviesWidget(
                      index: index,
                    );
                  },
                ));
          },
        )
        // body: ListView.builder(
        // itemCount: 10,
        //   itemBuilder: (context, index) {
        //     return MoviesWidget(
        //       index: 0,
        //     );
        //   },
        // ),
        );
    // );
  }
}
