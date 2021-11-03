import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
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
                itemBuilder: (_, index) => Text('$index'),
              ),
            ),
            Divider(thickness: 1.0),
            Container(
              height: 100,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
