import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea(
      {Key? key, required this.child, this.color, this.unSafeAreaHeight = 40})
      : assert(unSafeAreaHeight >= 25,
            "unsafeAreaHeight cannot be smaller than 25"),
        super(key: key);

  final Widget child;
  final Color? color;
  final double unSafeAreaHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      Container(
        height: unSafeAreaHeight,
        color: color,
      )
    ]);
  }
}
