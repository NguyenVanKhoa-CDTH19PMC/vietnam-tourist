import 'dart:convert';
import 'dart:developer';
import 'package:vietnam_tourist/providers/server_url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:vietnam_tourist/models/user.dart';
import 'package:meta/meta.dart';

class AuthcubitCubit extends Cubit<AuthcubitState> {
  AuthcubitCubit() : super(AuthcubitInitial());
  String accessToken = '';
  bool _isLoggedIn = false;
  User user = User();
  Map<String, dynamic> js = {};
  final storage = FlutterSecureStorage();
  Future loginMethod({required String email, required String password}) async {
    emitWaiting();
    try {
      js = SendAuth(email: email, password: password).toJson();
      log(jsonEncode(js).length.toString());
      var responce = await http.post(Uri.parse(serverUrl() + 'api/login'),
          body: jsonEncode(js), headers: headers);
      if (responce.statusCode == 200) {
        emitLoged();
        accessToken = jsonDecode(responce.body)['access_token'];
        getProfile('1');
        await storage.write(key: 'token', value: accessToken);
        await storage.write(key: 'name', value: user.name);
        await storage.write(key: 'id', value: user.id.toString());
        await storage.write(key: 'isLogined', value: 'y');
        log(accessToken);
        // username = tt.user.name.toString();

      } else {
        emitFailed();
        log(responce.statusCode.toString());
      }
    } on Exception catch (error) {
      log(error.toString());
      emitFailed();
    }
  }

  void getProfile(String id) async {
    try {
      final response = await http.get(Uri.parse(serverUrl() + 'api/user/$id'));
      final extractedData = json.decode(response.body);

      if (extractedData != null) {
        user = User.fromJson(extractedData);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void tryToken({required String token}) async {
    if (token == null) {
      return;
    } else {
      try {
        var response = await http.get(Uri.parse(serverUrl() + 'api/profile'),
            headers: headers);
        log(response.body);
        final parsed = json.decode(response.body);
        user = User.fromJson(parsed);
        _isLoggedIn = true;

        accessToken = token;
        await storage.write(key: 'token', value: token);
        await storage.write(key: 'name', value: user.name);
      } catch (e) {
        print(e);
      }
    }
  }

  Future registerMethod(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    emitWaiting();

    try {
      js = RegisterAuth(
              name: name,
              email: email,
              password: password,
              passwordConfirmation: confirmPassword)
          .toJson();
      var responce = await http.post(Uri.parse(serverUrl() + 'api/register'),
          body: jsonEncode(js), headers: headers);

      if (responce.statusCode == 200) {
        if (jsonDecode(responce.body)['email'] != null) return emitFailed();
        var tt = RespAuth.fromJson(jsonDecode(responce.body));
        emitLoged();
        accessToken = tt.token;
        // username = tt.user.name.toString();
        log(accessToken);
      } else {
        emitFailed();
        log(responce.statusCode.toString());
      }
    } on Exception catch (error) {
      log(error.toString());
      emitFailed();
    }
  }

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Content-Length": jsonEncode(js).length.toString(),
        "Authorization": "Bearer $accessToken",
      };

  void emitFailed() => emit(AuthcubitFailed());
  void emitWaiting() => emit(AuthcubitWaiting());
  void emitLoged() => emit(AuthcubitLoged());
  void emitLogout() => emit(AuthcubitLogout());
}

@immutable
abstract class AuthcubitState {}

class AuthcubitInitial extends AuthcubitState {}

class AuthcubitWaiting extends AuthcubitState {}

class AuthcubitLoged extends AuthcubitState {}

class AuthcubitLogout extends AuthcubitState {}

class AuthcubitFailed extends AuthcubitState {}
