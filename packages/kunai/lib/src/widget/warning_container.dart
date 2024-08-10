import 'package:flutter/material.dart';

class WarningContainer extends StatelessWidget {
  const WarningContainer({
    super.key,
    required this.message,
    this.textStyle,
    this.borderRadius,
    this.color,
    this.margin,
    this.visible = true,
    this.padding = const EdgeInsets.all(8),
  });

  final String message;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Container(
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(10),
                color: color ?? Colors.amber.withOpacity(0.7)),
            child: Text(
              message,
            ),
          )
        : const SizedBox.shrink();
  }
}
