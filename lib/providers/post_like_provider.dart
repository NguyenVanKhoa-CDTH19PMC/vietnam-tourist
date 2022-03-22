import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/models/like.dart';
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/image.dart';

class PostLikeProvider with ChangeNotifier {
  Future<List<Like>> fetchAndSetPostLikes(String id) async {
    try {
      final response = await http.get(
          Uri.parse(serverUrl() + 'api/post-like/$id'),
          headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (extractedData == null) {
          return <Like>[];
        }
        notifyListeners();
        return extractedData.map<Like>((json) => Like.fromJson(json)).toList();
      } else
        return <Like>[];
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future likePost(Like like) async {
    final response = await http.post(
      Uri.parse(serverUrl() + 'api/like-post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': like.userId.toString(),
        'postId': like.postId.toString(),
        'like': like.like.toString()
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Like.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
