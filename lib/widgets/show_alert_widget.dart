import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert({
  @required BuildContext context,
  @required String title,
  @required String content,
}) {
  Platform.isAndroid
      ? showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              MaterialButton(
                child: Text('Ok'),
                color: Colors.blue,
                elevation: 5.0,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        )
      : showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Ok'),
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
}
