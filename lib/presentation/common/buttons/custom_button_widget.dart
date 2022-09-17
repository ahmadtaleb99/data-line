import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style:  Theme.of(context).elevatedButtonTheme.style?.copyWith(

          backgroundColor: MaterialStateProperty.all(color)
        ),
        onPressed: onPressed, child: Text(text));
  }

  const CustomButtonWidget({
    required this.text,
    this.onPressed,
    this.color,
  });
}
