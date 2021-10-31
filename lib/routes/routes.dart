import 'package:chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/screens/loading_screen.dart';
import 'package:chat_flutter/screens/login_screen.dart';
import 'package:chat_flutter/screens/register_screen.dart';
import 'package:chat_flutter/screens/usuarios_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'chat': (_) => ChatScreen(),
  'loading': (_) => LoadingScreen(),
  'login': (_) => LoginScreen(),
  'register': (_) => RegisterScreen(),
  'usuarios': (_) => UsuariosScreen()
};
