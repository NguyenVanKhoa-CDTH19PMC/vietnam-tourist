import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/image.dart';

class PostPictureProvider with ChangeNotifier {
  Future<List<Picture>> fetchAndSetPostPictures(String id) async {
    try {
      final response = await http.get(
          Uri.parse(serverUrl() + 'api/post-image/$id'),
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
      throw error;
    }
  }
}
