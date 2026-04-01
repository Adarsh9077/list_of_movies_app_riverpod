import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';

import '../widgets/my_error_widget.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(WidgetRef ref) async {
    await Future.microtask(() async {
      await ref.read(moviesProvider.notifier).getMovies();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final moviesStateProvider = ref.watch(moviesProvider);
    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            if (ref.watch(moviesProvider).genresList.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>()
                    .navigateReplace(const MoviesScreen());
              });
            }
            return MyErrorWidget(
                errorText: snapshot.hasError.toString(),
                retryFunction: () async {
                  _loadInitialData(ref);
                });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getIt<NavigationService>().navigateReplace(const MoviesScreen());
            });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
