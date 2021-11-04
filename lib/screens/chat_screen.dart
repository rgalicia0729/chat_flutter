import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    for (ChatMessageWidget chatMessage in _messages) {
      chatMessage.animationController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('MF', style: TextStyle(fontSize: 12.0)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
            ),
            SizedBox(height: 3.0),
            Text(
              'Melissa Flores',
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
      uid: '123',
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
  }
}
