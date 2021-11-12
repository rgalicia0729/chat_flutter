import 'package:chat_flutter/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_flutter/models/users_model.dart';
import 'package:chat_flutter/services/users_service.dart';
import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/services/socket_service.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  RefreshController _refreshController =
      new RefreshController(initialRefresh: false);

  UsersService usersService = new UsersService();
  List<Usuario> usuarios = [];

  @override
  void initState() {
    _refreshUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () async {
            socketService.disconnect();
            await authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        title: Text(usuario.name, style: TextStyle(color: Colors.black87)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: (socketService.serverStatus == ServerStatus.Online)
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.offline_bolt, color: Colors.red),
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
    UsersModel usersModel = await usersService.fetchUsers();

    setState(() {
      usuarios = usersModel.usuarios;
    });

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
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.targetUser = usuario;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }
}
