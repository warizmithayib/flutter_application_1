class Holiday {
  late String name;
  late String date;

  Holiday.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    date = json["date"].toString();
  }
}
