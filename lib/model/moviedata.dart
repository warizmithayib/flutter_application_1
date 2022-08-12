class Movie {
  late int id;

  late String title;

  late String overview;

  late String posterImage;

  late String backdropPath;

  late double voteAverage;

  Movie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    overview = json["overview"];
    //non nullable solution
    //?? = jika null, isi "", jika not null isi "poster_path"
    posterImage = json["poster_path"] ?? "";
    backdropPath = json["backdrop_path"] ?? "";
    voteAverage = double.parse(json["vote_average"]!.toString());
    //parse untuk mengubah string menjadi double
  }
}
