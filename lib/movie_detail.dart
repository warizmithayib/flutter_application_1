import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/moviedata.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'config/globals.dart';

class MovieDetailWidget extends StatelessWidget {
  const MovieDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: Stack(
        //membuat layer/tumpukan widget
        fit: StackFit.expand,
        children: [
          Image.network(
            MOVIE_DB_IMAGE_URL + movie.backdropPath,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              )),
          ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 250,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.amber,
                        blurRadius: 50,
                        offset: Offset(0, 1),
                      )
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                            MOVIE_DB_IMAGE_URL + movie.posterImage),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20.0),
                    child:
                        // Expanded(
                        //   child:
                        Text(
                      movie.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar.builder(
                          itemSize: 25,
                          initialRating: movie.voteAverage,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 10,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(25),
                child: Text(
                  movie.overview,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 90.0, horizontal: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Play"),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share('check out my website https://example.com');
                      },
                      icon: const Icon(Icons.share),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
