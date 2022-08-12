import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/moviedata.dart';
import 'package:flutter_application_1/searchbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'config/globals.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({Key? key}) : super(key: key);

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  var currentIndex = 0;
  //^variable untuk select current bottomNavigationBar
  Future<List<Movie>> getMovies() async {
    //^fungsi yang asynchronous akan menjalankan fungsi Future<dynamic>
    var theApi = "popular";
    if (currentIndex == 1) {
      theApi = "top_rated";
    } else if (currentIndex == 2) {
      theApi = "now_playing";
    }
    //^kondisi untuk bottomNavigationBar
    //theApi = currentIndex == 0 ? "popular" : currentIndex == 1 ? "top_rate" : "now_playing";
    //^penulisan lain kondisi
    var apiUrl = Uri.https(MOVIE_DB_API_URL, "3/movie/" + theApi, {
      "api_key": MOVIE_DB_API_KEY,
    });
    var response = await http.get(apiUrl);
    var data = json.decode(response.body);

    List<Movie> movies = [];
    //definisi arrayList movies untuk data dinamis
    //jika arrayList sudah ditentukan akan menjadi movies.m1, movies.m2
    //hasilnya akan menjadi arrayList untuk masing2 movie
    var dt = data["results"] as List<dynamic>;
    for (var element in dt) {
      //looping untuk select setiap elemen pada json
      var m = Movie.fromJson(element);
      //memisahkan data ke kategori moviedata.dart ke variabel m
      movies.add(m);
      //masukkan data ke arrayList movies untuk nanti ditampilkan
    }
    return movies;
    //output dari fungsi getMovies adalah movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(),
      bottomNavigationBar: BottomNavigationBar(
        //widget dalam Scaffold untuk bottom menu
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;

          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Popular"),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up), label: "Top Rated"),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow), label: "Now Playing"),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        //variasi <List<Movie>> agar tidak usah definisi variabel di snapshot
        future: getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Please try again"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            //maka datanya sudah didapatkan
            //return Text("Success!!");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              //data'!' untuk null check
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CachedNetworkImage(
                            height: 150,
                            imageUrl: MOVIE_DB_IMAGE_URL +
                                snapshot.data![index].posterImage,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),

                          // Image.network(
                          //     "https://image.tmdb.org/t/p/w500/" +
                          //         snapshot.data![index].posterImage),
                        ),
                        SizedBox(
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    var movie = snapshot.data![index];
                                    Navigator.pushNamed(
                                        context, "page_movie_detail",
                                        arguments: movie);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      snapshot.data![index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  snapshot.data![index].overview
                                      .substring(0, 100),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // collection --> document --> field
                                  var fs = FirebaseFirestore.instance;
                                  fs.collection("bookings").add({
                                    "movieId": snapshot.data![index].id,
                                    "title": snapshot.data![index].title,
                                    "overview": snapshot.data![index].overview,
                                    "posterPath":
                                        snapshot.data![index].posterImage,
                                  }).then((value) {
                                    Fluttertoast.showToast(
                                        msg: "Booking success!");
                                  });
                                },
                                child: const Text("Book this movie"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 3,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
