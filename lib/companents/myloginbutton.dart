// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';

class MyLoginButton extends StatelessWidget {
  const MyLoginButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.style,
  });

  final Widget child;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 70, right: 70),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style != null
            ? style
            : ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
        child: child,
      ),
    );
  }
}
