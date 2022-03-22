import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vietnam_tourist/providers/server_url.dart';

import '../models/post.dart';

class PostProvider with ChangeNotifier {
  Future<List<Post>> fetchAndSetPosts() async {
    try {
      final response = await http.get(Uri.parse(serverUrl() + 'api/post'));
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (extractedData == null) {
          return [];
        }
        notifyListeners();
        return extractedData.map<Post>((json) => Post.fromJson(json)).toList();
      } else
        return [];
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future createPost(String userId, String placenameId, String content,
      List<File> files) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(serverUrl() + 'api/post'));

    request.fields['userId'] = userId;
    request.fields['placenameId'] = placenameId;
    request.fields['content'] = content;

    for (int i = 0; i < files.length; i++) {
      // File imageFile = File(files[i].toString());
      // var stream = http.ByteStream(DelegatingStream(files[i].openRead()));
      request.files
          .add(await http.MultipartFile.fromPath('files', files[i].path));
    }

    request.send().then((response) {
      if (response.statusCode == 200)
        print("Uploaded!");
      else {
        log(response.statusCode.toString());
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create post.');
      }
    });
  }
}
