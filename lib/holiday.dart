import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/holidaydata.dart';

class HolidayWidget extends StatefulWidget {
  const HolidayWidget({Key? key}) : super(key: key);

  @override
  State<HolidayWidget> createState() => _HolidayWidgetState();
}

class _HolidayWidgetState extends State<HolidayWidget> {
  Future<List<Holiday>> getHolidays() async {
    //https://holidayapi.com/v1/holidays?pretty&key=1febbe8f-daf9-4a9e-9839-755b150207fa&country=ID&year=2021
    var url = Uri.https("holidayapi.com", "/v1/holidays", {
      "pretty": "",
      "key": "1febbe8f-daf9-4a9e-9839-755b150207fa",
      "country": "ID",
      "year": "2021",
    });

    var response = await http.get(url);
    var data = json.decode(response.body);

    List<Holiday> holiday = [];

    var dt = data["holidays"] as List<dynamic>;

    for (var element in dt) {
      holiday.add(Holiday.fromJson(element));
    }
    return holiday;
  }

  bool isworking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List of Holidays"),
        ),
        body: FutureBuilder<List<Holiday>>(
            future: getHolidays(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: TextButton(
                        onPressed: isworking
                            ? null
                            : () {
                                Future.delayed(const Duration(seconds: 3), () {
                                  setState(() {
                                    isworking = !isworking;
                                  });
                                });
                              },
                        child: isworking
                            ? const Text("Please try again later")
                            : const Text(
                                "Bad connection, Tap here to try again")));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            snapshot.data![index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(snapshot.data![index].date),
                        ],
                      );
                    });
              }
            }));
  }
}
