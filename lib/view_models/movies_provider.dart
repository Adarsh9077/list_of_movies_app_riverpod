import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/view_models/movies_state.dart';
import 'package:riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

final moviesProvider = StateNotifierProvider<MoviesProvider, MovieState>(
  (ref) => MoviesProvider(),
);

final currentMovie = Provider.family<MovieModel, int>(
  (ref, index) {
    final movieState = ref.watch(moviesProvider);
    return movieState.moviesList[index];
  },
);

class MoviesProvider extends StateNotifier<MovieState> {
  MoviesProvider() : super(MovieState(genresList: [], moviesList: [])) {
    getMovies();
  }

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();
  Future<void> getMovies() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      print("object MoviesRepository - ");

      /// Fetch genres once
      if (state.genresList.isEmpty) {
        final genresList = await _moviesRepository.fetchGenres();
        state = state.copyWith(genreMovies: genresList);
      }

      print("object MoviesRepository - ${state.genresList.isEmpty}");

      final movies = await _moviesRepository.fetchMovies(
        page: state.currentPage!,
      );

      state = state.copyWith(
        movies: [...state.moviesList, ...movies],
        currentPage: state.currentPage! + 1,
        fetchMoviesError: '',
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        fetchMoviesError: e.toString(),
        isLoading: false,
      );
    }
  }
}
