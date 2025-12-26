import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/widgets/movies/favorite_btn.dart';

import '../models/movies_model.dart';
import '../widgets/cached_image.dart';
import '../widgets/movies/genres_list_widget.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({
    super.key,
    required this.index,
  });
  final int index;
  // final MovieModel movieModel;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final movieState = ref.watch(currentMovie(index));
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.45,
              width: double.infinity,
              child: CachedImageWidget(
                imgUrl: 
                // MyAppConstants.movieImage,
                "https://image.tmdb.org/t/p/w500/${movieState.backdropPath}",
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                    // child: Container(color: Colors.red,),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25),
                                Text(
                                  movieState.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    // color: Theme.of(context).textSelectionColor,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                    "${movieState.voteAverage.toStringAsFixed(1)}/10"),
                                    Spacer(),
                                    Text(
                                      movieState.releaseDate,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                GenresListWidget(
                                    // movieModel: movieModel,
                                    ),
                                SizedBox(height: 15),
                                Text(
                                  movieState.overview,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: FavoriteBtnWidget(
                                  // movieModel: movieModel,
                                  )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const BackButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
