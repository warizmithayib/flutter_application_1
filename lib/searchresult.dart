import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/globals.dart';
import 'package:flutter_application_1/favorite_movie.dart';
import 'package:flutter_application_1/model/moviedata.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  Future<List<Movie>> searchMovie(String search) async {
    var url = Uri.https(MOVIE_DB_API_URL, "/3/search/movie", {
      "api_key": MOVIE_DB_API_KEY,
      "query": search,
    });
    var response = await http.get(url);
    var data = json.decode(response.body);
    var dt = data["results"] as List<dynamic>;

    List<Movie> movies = [];
    for (var element in dt) {
      Movie m = Movie.fromJson(element);
      movies.add(m);
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    var search = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      body: FutureBuilder<List<Movie>>(
          future: searchMovie(search),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Please try again"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var movie = snapshot.data![index];
                    Color warna = Colors.white;
                    var box = Hive.box("favorite_movie");
                    for (var element in box.keys) {
                      if (box.get(element) == movie.id) {
                        warna = Colors.red;
                      }
                    }
                    return FavoriteMovieWidget(m: movie);
                  });
            }
          }),
    );
  }
}
