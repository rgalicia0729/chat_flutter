import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool obscureText;

  TextFieldWidget({
    Key key,
    @required this.prefixIcon,
    @required this.hintText,
    @required this.textController,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, left: 5.0, bottom: 5.0, right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5.0,
          )
        ],
      ),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
