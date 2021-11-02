import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String labelText;
  final Function onPressed;
  final Color backgroundColor;
  final Color textColor;

  ElevatedButtonWidget({
    Key key,
    @required this.labelText,
    @required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 50.0,
      width: size.width,
      child: ElevatedButton(
        child: Text(
          labelText,
          style: TextStyle(
            color: textColor,
            fontSize: 17.0,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 3.0,
          primary: backgroundColor,
          shape: StadiumBorder(),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
