import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_flutter/models/auth_model.dart';

// ignore: must_be_immutable
class UsuariosScreen extends StatelessWidget {
  RefreshController _refreshController =
      new RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [
    Usuario(id: '1', name: 'Melissa', email: 'test1@test.com', online: true),
    Usuario(id: '2', name: 'Felipe', email: 'test2@test.com', online: false),
    Usuario(id: '3', name: 'Santiago', email: 'test3@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {},
        ),
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.offline_bolt, color: Colors.red),
            // Icon(Icons.check_circle, color: Colors.green)
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _refreshUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) =>
          _UsuarioListTileWidget(usuario: usuarios[index]),
      separatorBuilder: (_, index) => Divider(thickness: 1.0),
      itemCount: usuarios.length,
    );
  }

  _refreshUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}

// Usuario list tile widget
class _UsuarioListTileWidget extends StatelessWidget {
  final Usuario usuario;

  _UsuarioListTileWidget({Key key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(usuario.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: usuario.online ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
