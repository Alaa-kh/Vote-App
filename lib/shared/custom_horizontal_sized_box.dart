import 'package:flutter/material.dart';

class CustomHorizontalSizedBox extends StatelessWidget {
  final double width;

  const CustomHorizontalSizedBox(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
