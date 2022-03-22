import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vietnam_tourist/providers/server_url.dart';

class Placename {
  int? id;
  String? name = "";
  String? area = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String? description;
  String? specialties;

  Placename({id, name, description, coordinates});

  Placename.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    area = json["area"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    description = json["description"];
    specialties = json["specialties"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = id;
    data["name"] = name;
    data["area"] = area;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["description"] = description;
    data["specialties"] = specialties;
    return data;
  }
}
