import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
    this.size = 1,
    this.direction,
    this.padding,
    this.margin,
    this.color,
    this.width,
    this.constraints,
  }) : super(key: key);

  final double size;
  final Direction? direction;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final Color? color;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    if (direction == Direction.vertical) {
      return Container(
        constraints: constraints,
        color: color ?? Colors.grey,
        padding: padding,
        margin: margin,
        height: size,
        width: width ?? 1,
      );
    } else {
      return Container(
        constraints: constraints,
        color: color ?? Colors.grey,
        padding: padding,
        margin: margin,
        width: width,
        height: size,
      );
    }
  }
}

enum Direction { horizontal, vertical }
