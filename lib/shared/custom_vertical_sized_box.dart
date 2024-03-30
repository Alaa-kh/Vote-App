import 'package:flutter/material.dart';

class CustomVerticalSizedBox extends StatelessWidget {
  final double height;

  const CustomVerticalSizedBox(this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
