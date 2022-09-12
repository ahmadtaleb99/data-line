import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {

  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }

  const CustomButtonWidget({
    required this.text,
    this.onPressed,
  });
}
