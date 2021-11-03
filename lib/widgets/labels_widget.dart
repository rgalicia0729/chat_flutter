import 'package:flutter/material.dart';

class LabelsWidget extends StatelessWidget {
  final String labelMessage;
  final String labelPath;
  final String path;

  LabelsWidget({
    Key key,
    @required this.labelMessage,
    @required this.labelPath,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            labelMessage,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            child: Text(
              labelPath,
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, path);
            },
          ),
        ],
      ),
    );
  }
}
