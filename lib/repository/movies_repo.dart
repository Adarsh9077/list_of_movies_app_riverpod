import 'package:mvvm_statemanagements/service/api_service.dart';

import '../models/movies_genre.dart';
import '../models/movies_model.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository(this._apiService);

  Future<List<MovieModel>> fetchMovies({int? page}) async {
    return await _apiService.fetchMovies(page: page ?? 1);
  }

  // List<MoviesGenre> cachedGenres = [];
  Future<List<MoviesGenre>> fetchGenres() async {
    // return cachedGenres = await _apiService.fetchGenres();
    return await _apiService.fetchGenres();
  }
}
