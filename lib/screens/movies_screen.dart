import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';
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
            Consumer(
              builder: (context, ref, child) {
                return IconButton(
                  onPressed: () async {
                    // themeState.
                    // final List<MovieModel> movies = await getIt<ApiService>().fetchMovies();
                    // log("movies $movies");
                    // final List<MoviesGenre> genres =
                    //     await getIt<MoviesRepository>().fetchGenres();
                    // await getIt<ApiService>().fetchGenres();

                    // log("Genres are $genres");
                    // themeState.toggleTheme();
                    await ref.read(themeProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                    themeState == ThemeEnums.dark
                        ? MyAppIcons.darkMode
                        : MyAppIcons.lightMode,
                  ),
                );
              },
            )
          ],
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final movieState = ref.watch(moviesProvider);
            if (movieState.isLoading && movieState.moviesList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (movieState.fetchMoviesError.isNotEmpty) {
              return Center(
                child: Text(movieState.fetchMoviesError),
              );
            }
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    !movieState.isLoading) {
                  ref.read(moviesProvider.notifier).getMovies();
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const MoviesWidget();
                },
              ),
            );
          },
        )

        // ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) {
        //     return const MoviesWidget();
        //   },
        // ),
        );
  }
}

//! 74 start
