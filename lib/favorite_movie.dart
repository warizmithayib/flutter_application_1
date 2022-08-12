import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/globals.dart';
import 'package:hive/hive.dart';
import 'model/moviedata.dart';

class FavoriteMovieWidget extends StatefulWidget {
  //  const FavoriteMovieWidget({Key? key}) : super(key: key);
  var movie;

  FavoriteMovieWidget({required Movie m}) {
    movie = m;
  }

  @override
  State<FavoriteMovieWidget> createState() => _FavoriteMovieWidgetState();
}

void deleteFavorites(Key) {
  var box = Hive.box("favorite_movie");
  box.delete(Key);
}

class _FavoriteMovieWidgetState extends State<FavoriteMovieWidget> {
  @override
  Widget build(BuildContext context) {
    Color warna = Colors.white;
    var box = Hive.box("favorite_movie");

    // box.keys.forEach((element) {
    //   // if (box.get(element) == widget.movie.id) {
    //   //   warna = Colors.red;
    //   //   print(box.keys);
    //   // }
    // });
    var sudahDiLike = box.get(widget.movie.id) ?? 0;
    if (sudahDiLike != 0) warna = Colors.red;
    return GridTile(
      footer: GridTileBar(
        leading: GestureDetector(
            onTap: () {
              if (sudahDiLike != 0) {
                deleteFavorites(widget.movie.id);
              } else {
                var box = Hive.box("favorite_movie");
                box.put(widget.movie.id, widget.movie.id);
              }

              // box.add(widget.movie.id);
              // box.deleteAll(box.keys);
              // box.delete(box.keys.elementAt(0));
              // box.delete(box.keys.first);

              // box.delete(box.containsKey(widget.movie.id));
              // box.delete(box.containsKey(true));
              // box.delete(box.keys.contains(widget.movie.id == true));
              setState(() {});
            },
            child: Icon(
              Icons.favorite,
              color: warna,
            )),
        title: Text(widget.movie.title),
        trailing: const Icon(Icons.share),
      ),
      child:
          //error handler
          widget.movie.posterImage.isEmpty
              ? Container()
              : CachedNetworkImage(
                  imageUrl: MOVIE_DB_IMAGE_URL + widget.movie.posterImage,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Text(error.toString());
                  },
                ),
    );
  }
}
