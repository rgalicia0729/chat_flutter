import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/screens/login_screen.dart';
import 'package:chat_flutter/screens/usuarios_screen.dart';
import 'package:chat_flutter/services/auth_service.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: Text('Espere', style: TextStyle(fontSize: 14.0)),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autheticated = await authService.isLoggedIn();

    if (autheticated) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosScreen(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginScreen(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    }
  }
}
