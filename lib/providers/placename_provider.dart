import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/placename.dart';

class PlacenameProvider with ChangeNotifier {
  Future<List<Placename>> fetchAndSetPlacenames() async {
    try {
      final response = await http.get(Uri.parse(serverUrl() + 'api/placename'));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return [];
      }
      notifyListeners();
      return extractedData
          .map<Placename>((json) => Placename.fromJson(json))
          .toList();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<List<Placename>> fetchAndSetPlacenamesOfArea(String area) async {
    try {
      final response = await http
          .get(Uri.parse(serverUrl() + 'api/placename_of_area/$area'));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return [];
      }
      notifyListeners();
      return extractedData
          .map<Placename>((json) => Placename.fromJson(json))
          .toList();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<Placename> fetchAndSetPlacename(String id) async {
    try {
      final response =
          await http.get(Uri.parse(serverUrl() + 'api/placename/$id'));
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (extractedData == null) {
          return Placename();
        }
        notifyListeners();
        return Placename.fromJson(extractedData);
      } else
        return Placename();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
