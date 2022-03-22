import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/models/type.dart';
import 'package:vietnam_tourist/providers/server_url.dart';

class PlacenameTypeProvider with ChangeNotifier {
  Future<List<Type>> fetchAndSetPlacenameTypes(String id) async {
    try {
      final response =
          await http.get(Uri.parse(serverUrl() + 'api/placename-type/$id'));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return <Type>[];
      }
      notifyListeners();
      return extractedData.map<Type>((json) => Type.fromJson(json)).toList();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
