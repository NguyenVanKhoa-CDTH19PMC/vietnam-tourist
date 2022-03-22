import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'server_url.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

  Future<User?> fetchAndSetUsers() async {
    try {
      final response = await http.get(Uri.parse(serverUrl() + 'api/user'));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return null;
      }
      _users = extractedData.map<User>((json) => User.fromJson(json)).toList();

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<User> fetchAndSetUser(String id) async {
    try {
      final response = await http.get(Uri.parse(serverUrl() + 'api/user/$id'));
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return User();
      }
      notifyListeners();
      return User.fromJson(extractedData);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
