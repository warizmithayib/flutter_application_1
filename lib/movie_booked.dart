import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/globals.dart';

class MovieBookedWidget extends StatelessWidget {
  const MovieBookedWidget({Key? key}) : super(key: key);

  getMoviesBooked() {
    var fs = FirebaseFirestore.instance;
    return fs.collection("bookings").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Movies Booked"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getMoviesBooked(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Please try again");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            var data = snapshot.data as QuerySnapshot;
            var list = data.docs;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var booking = list[index].data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CachedNetworkImage(
                              height: 150,
                              imageUrl:
                                  MOVIE_DB_IMAGE_URL + booking["posterPath"],
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      booking["title"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    booking["overview"],
                                    textAlign: TextAlign.justify,
                                  ),
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
                });
          }
        },
      ),
    );
  }
}
