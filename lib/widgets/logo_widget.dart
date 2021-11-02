import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String labelText;

  LogoWidget({
    Key key,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 60.0),
        width: 170.0,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('lib/assets/tag-logo.png')),
            SizedBox(height: 20.0),
            Text(labelText, style: TextStyle(fontSize: 30.0))
          ],
        ),
      ),
    );
  }
}
