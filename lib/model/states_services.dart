import 'dart:convert';
import 'package:covid_tracker/model/WorldStatesApi.dart';
import 'package:covid_tracker/model/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesApi> worldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var worldRecordData = jsonDecode(response.body.toString());
      return WorldStatesApi.fromJson(worldRecordData);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> Countrieslistrecord() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
