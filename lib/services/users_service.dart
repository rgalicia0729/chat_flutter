import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:chat_flutter/global/environments.dart';
import 'package:chat_flutter/models/users_model.dart';
import 'package:chat_flutter/services/auth_service.dart';

class UsersService {
  Future<UsersModel> fetchUsers() async {
    UsersModel usersModel = new UsersModel();

    try {
      final url = Uri.parse('${Environments.serverUrl}/users');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      usersModel = new UsersModel.fromJson(jsonDecode(response.body));
      return usersModel;
    } catch (err) {
      return usersModel;
    }
  }
}
