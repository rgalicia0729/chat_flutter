import 'package:flutter/material.dart';

import 'package:chat_flutter/models/users_model.dart';

class ChatService with ChangeNotifier {
  Usuario _targetUser;

  Usuario get targetUser => this._targetUser;

  set targetUser(Usuario value) => this._targetUser = value;
}
