import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class MovieState {
  final int? currentPage;
  final List<MovieModel> moviesList;
  final List<MoviesGenre> genresList;
  final bool isLoading;
  final String fetchMoviesError;

  MovieState(
      {this.currentPage = 1,
      required this.moviesList,
      required this.genresList,
      this.isLoading = false,
      this.fetchMoviesError = ''});
  MovieState copyWith(
      {int? currentPage,
      List<MovieModel>? movies,
      List<MoviesGenre>? genreMovies,
      bool? isLoading,
      String? fetchMoviesError}) {
    return MovieState(
        currentPage: currentPage ?? this.currentPage,
        moviesList: movies ?? this.moviesList,
        genresList: genreMovies ?? this.genresList,
        isLoading: isLoading ?? this.isLoading,
        fetchMoviesError: this.fetchMoviesError);
  }

  // state = MovieState.copyWith();
}

// class MovieState {
//   final List<MovieModel> moviesList;
//   final List<MoviesGenre> genresList;
//   final bool isLoading;
//   final int? currentPage;
//   final String fetchMoviesError;

//   MovieState({
//     required this.moviesList,
//     required this.genresList,
//     this.isLoading = false,
//     this.currentPage = 1,
//     this.fetchMoviesError = '',
//   });

//   MovieState copyWith({
//     List<MovieModel>? moviesList,
//     List<MoviesGenre>? genresList,
//     bool? isLoading,
//     int? currentPage,
//     String? fetchMoviesError,
//   }) {
//     return MovieState(
//       moviesList: moviesList ?? this.moviesList,
//       genresList: genresList ?? this.genresList,
//       isLoading: isLoading ?? this.isLoading,
//       currentPage: currentPage ?? this.currentPage,
//       fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
//     );
//   }
// }
