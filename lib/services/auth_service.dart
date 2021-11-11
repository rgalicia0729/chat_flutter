import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_flutter/global/environments.dart';
import 'package:chat_flutter/models/auth_model.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _authenticating = false;
  bool _registering = false;
  final _storage = new FlutterSecureStorage();

  get authenticating => this._authenticating;

  get registering => this._registering;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  set registering(bool value) {
    this._registering = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  static Future deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> signin(String email, String password) async {
    this.authenticating = true;

    final url = Uri.parse('${Environments.serverUrl}/auth/signin');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    this.authenticating = false;
    if (response.statusCode == 200) {
      final authModel = new AuthModel.fromJson(json.decode(response.body));
      this.usuario = authModel.usuario;

      await _storage.write(key: 'token', value: authModel.token);

      return true;
    }

    return false;
  }

  Future<bool> signup({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    this.registering = true;

    final url = Uri.parse('${Environments.serverUrl}/auth/signup');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    this.registering = false;
    if (response.statusCode == 201) {
      final authModel = new AuthModel.fromJson(json.decode(response.body));
      this.usuario = authModel.usuario;

      await _storage.write(key: 'token', value: authModel.token);

      return true;
    }

    return false;
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    if (token == null || token == '') {
      return false;
    }

    final url = Uri.parse('${Environments.serverUrl}/auth/current-user');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      },
    );

    if (response.statusCode == 200) {
      final authModel = new AuthModel.fromJson(json.decode(response.body));
      this.usuario = authModel.usuario;

      await _storage.write(key: 'token', value: authModel.token);

      return true;
    } else {
      logout();
      return false;
    }
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
