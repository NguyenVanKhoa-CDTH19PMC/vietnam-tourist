import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/image.dart';

class PlacenamePictureProvider with ChangeNotifier {
  Future<List<Picture>> fetchAndSetPlacenamePictures(String id) async {
    try {
      final response = await http.get(
          Uri.parse(serverUrl() + 'api/placename-image/$id'),
          headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (extractedData == null) {
          return <Picture>[];
        }
        notifyListeners();
        return extractedData
            .map<Picture>((json) => Picture.fromJson(json))
            .toList();
      } else
        return <Picture>[];
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
