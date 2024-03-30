
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? label;
  final double? size;
  final Function()? onPressed;

  LoginButton({this.label, this.size, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: MaterialButton(
        height: 60.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.blueAccent[200],
        child: Text(
          label!,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
