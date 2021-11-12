import 'dart:io';

import 'package:chat_flutter/services/auth_service.dart';
import 'package:chat_flutter/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/services/chat_service.dart';
import 'package:chat_flutter/widgets/chat_message_widget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _chatMessageController = new TextEditingController();
  final _focusNode = new FocusNode();

  bool _isWriting = false;
  List<ChatMessageWidget> _messages = [];

  ChatService _chatService;
  SocketService _socketService;
  AuthService _authService;

  @override
  void initState() {
    _chatService = Provider.of<ChatService>(context, listen: false);
    _socketService = Provider.of<SocketService>(context, listen: false);
    _authService = Provider.of<AuthService>(context, listen: false);

    _socketService.socket.on(
      'personal-message',
      (payload) => _listenToMessages(payload),
    );

    super.initState();
  }

  void _listenToMessages(dynamic payload) {
    ChatMessageWidget chatMessage = new ChatMessageWidget(
      uid: payload['id'],
      text: payload['message'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );

    setState(() {
      _messages.insert(0, chatMessage);
    });

    chatMessage.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatMessageWidget chatMessage in _messages) {
      chatMessage.animationController.dispose();
    }

    _socketService.socket.off('personal-message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetUser = _chatService.targetUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(
                targetUser.name.substring(0, 2),
                style: TextStyle(fontSize: 12.0),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
            ),
            SizedBox(height: 3.0),
            Text(
              targetUser.name,
              style: TextStyle(color: Colors.black87, fontSize: 12.0),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, index) => _messages[index],
              ),
            ),
            Divider(height: 1.0),
            Container(
              color: Colors.white,
              child: _chatMessage(),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatMessage() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _chatMessageController,
                focusNode: _focusNode,
                onSubmitted: _handleSubmit,
                onChanged: (String value) {
                  setState(() {
                    (value.trim().length > 0)
                        ? _isWriting = true
                        : _isWriting = false;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _isWriting
                          ? () =>
                              _handleSubmit(_chatMessageController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _isWriting
                              ? () => _handleSubmit(
                                  _chatMessageController.text.trim())
                              : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void _handleSubmit(String value) {
    if (value.length == 0) return;

    final newMessage = new ChatMessageWidget(
      uid: _authService.usuario.id,
      text: value,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    _chatMessageController.clear();
    _focusNode.requestFocus();

    setState(() {
      _isWriting = false;
    });

    _socketService.socket.emit('personal-message', {
      'from': _chatService.targetUser.id,
      'message': value,
    });
  }
}
