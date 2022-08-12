import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversitiesWidget extends StatefulWidget {
  const UniversitiesWidget({Key? key}) : super(key: key);

  @override
  State<UniversitiesWidget> createState() => _UniversitiesWidgetState();
}

class _UniversitiesWidgetState extends State<UniversitiesWidget> {
  List countries = [];
  var selectedCountries;

  getCountries() async {
    var url = Uri.https("api.first.org", "data/v1/countries");
    var response = await http.get(url);
    var data = json.decode(response.body); //quickfix untuk import dart:convert
    var result = data["data"] as Map<String, dynamic>;
    countries.add("");
    result.forEach((key, value) {
      //countries.add(value["country"] + " (" + value["region"] + ")");
      countries.add(value["country"]);
    });
    setState(() {});
  }

  getUniversities(String? selectedCountries) async {
    //Tambah ? jika value null
    if (selectedCountries == null) return null;

    var url = Uri.http(
        "universities.hipolabs.com", "/search", {"country": selectedCountries});
    var response = await http.get(url);
    var data = json.decode(response.body);
    return data;
  }

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Universities by Country"),
        actions: const [
          Tooltip(
            message:
                "This page will consume API from http://universities.hipolabs.com/",
            child: Icon(Icons.question_answer),
          )
        ],
      ),
      body: ListView(
        children: [
          DropdownButton(
              hint: const Text("Select Country"),
              value: selectedCountries,
              onChanged: (dynamic value) {
                selectedCountries = value;
                setState(() {});
              },
              items: countries.map((e) {
                String negara = e.toString().toUpperCase();
                return DropdownMenuItem(value: e, child: Text(negara));
              }).toList()),
          FutureBuilder(
              //widget utk menampilkan semua data dari json
              future: getUniversities(
                  selectedCountries), //tentukan data async yang akan ditampilkan
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var dataUniversities = snapshot.data as List<dynamic>;
                  if (dataUniversities.isEmpty) {
                    return const Text("No universities, try another country");
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const BouncingScrollPhysics(), //fungsi untuk scroll data melebihi layar
                    itemCount: dataUniversities.length,
                    itemBuilder: (BuildContext context, int index) {
                      var universities =
                          dataUniversities[index] as Map<String, dynamic>;
                      return Text(universities["name"]);
                      //return Text("Universities" + index.toString());
                    },
                  );
                  // return Center(
                  //     child: Text("Successfully get the universities data"));
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Please try again"));
                } else {
                  if (selectedCountries == null) {
                    return Container();
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              }),
        ],
      ),
    );
  }
}
