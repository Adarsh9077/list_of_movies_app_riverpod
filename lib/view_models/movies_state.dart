import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class MovieState {
  final int? currentPage;
  final List<MovieModel> moviesList;
  final List<MoviesGenre> genresList;
  final bool isLoading;
  final String? fetchMoviesError;

  MovieState(
      {this.currentPage = 1,
      this.moviesList = const [],
      this.genresList = const [],
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
        moviesList: moviesList ?? this.moviesList,
        genresList: genresList ?? this.genresList,
        isLoading: isLoading ?? this.isLoading,
        fetchMoviesError: this.fetchMoviesError);
  }
  // state = MovieState.copyWith();
}
