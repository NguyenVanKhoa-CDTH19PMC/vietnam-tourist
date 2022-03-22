import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/models/comment.dart';
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/image.dart';

class PostCommentProvider with ChangeNotifier {
  Future<List<Comment>> fetchAndSetPostComments(String id) async {
    try {
      final response =
          await http.get(Uri.parse(serverUrl() + 'api/post-comment/$id'));
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (extractedData == null) {
          return <Comment>[];
        }
        notifyListeners();
        return extractedData
            .map<Comment>((json) => Comment.fromJson(json))
            .toList();
      } else
        return <Comment>[];
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future commentPost(String userId, postId, content) async {
    final response = await http.post(
      Uri.parse(serverUrl() + 'api/comment-post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId.toString(),
        'postId': postId.toString(),
        'content': content.toString()
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create comment.');
    }
  }
}
