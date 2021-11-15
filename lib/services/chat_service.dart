import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_flutter/models/messages_model.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/global/environments.dart';
import 'package:chat_flutter/models/users_model.dart';

class ChatService with ChangeNotifier {
  Usuario _targetUser;

  Usuario get targetUser => this._targetUser;

  set targetUser(Usuario value) => this._targetUser = value;

  Future<MessagesModel> fetchMessages(String to) async {
    MessagesModel messagesModel = new MessagesModel();

    final url = Uri.parse('${Environments.serverUrl}/messages/$to');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    if (response.statusCode == 200) {
      messagesModel = new MessagesModel.fromJson(jsonDecode(response.body));
    }

    return messagesModel;
  }
}
