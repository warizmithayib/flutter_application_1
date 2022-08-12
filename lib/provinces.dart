import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProvincesWidget extends StatefulWidget {
  const ProvincesWidget({Key? key}) : super(key: key);

  @override
  State<ProvincesWidget> createState() => _ProvincesWidgetState();
}

class _ProvincesWidgetState extends State<ProvincesWidget> {
  List provinces = [];
  var selectedProvinces;

  getProvinces() async {
    var url = Uri.https("dev.farizdotid.com", "api/daerahindonesia/provinsi");
    var response = await http.get(url);
    var data = json.decode(response.body);
    //quickfix untuk import dart:convert
    var result = data["provinsi"] as List<dynamic>;
    for (var value in result) {
      provinces.add(value["nama"]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
