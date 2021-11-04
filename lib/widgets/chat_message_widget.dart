import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final String uid;
  final String text;
  final AnimationController animationController;

  ChatMessageWidget({
    Key key,
    @required this.uid,
    @required this.text,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 50.0, bottom: 5.0, right: 5.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFF4D9EF6),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 50.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFFE4E5E8),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
