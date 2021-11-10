import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_flutter/global/environments.dart';
import 'package:chat_flutter/models/auth_model.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _authenticating = false;

  get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
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

    print(response.body);
    this.authenticating = false;
    if (response.statusCode == 200) {
      final authModel = new AuthModel.fromJson(json.decode(response.body));
      this.usuario = authModel.usuario;

      return true;
    }

    return false;
  }
}
