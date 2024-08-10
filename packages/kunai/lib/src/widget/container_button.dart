import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';
import 'package:kunai/l10n/localizations_ext.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    this.visible = true,
    required Widget this.child,
    required this.onPressed,
    this.color,
    this.constraints = const BoxConstraints(maxWidth: 300.0),
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.invisiblePlaceHolder,
    this.label,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(15.0),
    ),
    this.height = 40.0,
    this.centerChild = true,
  }) : text = null, textColor = null;

  const ContainerButton.text({
    super.key,
    this.visible = true,
    required String this.text,
    required this.onPressed,
    this.textColor,
    this.color,
    this.constraints = const BoxConstraints(maxWidth: 300.0),
    this.padding = const EdgeInsets.all(8.0),
    this.margin,
    this.label,
    this.invisiblePlaceHolder,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(15.0),
    ),
    this.height = 40.0,
    this.centerChild = true,
  }) : child = null;

  final bool visible;
  final VoidCallback onPressed;
  final Color? color;
  final Widget? child;
  final Widget? invisiblePlaceHolder;
  final BoxConstraints constraints;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double height;
  final String? label;
  final bool centerChild;
  final Color? textColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return visible
        ? Semantics(
      label: label ?? context.kunaiL10n.button,
      child: Container(
        constraints: constraints,
        padding: padding,
        margin: margin,
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
              color ?? Theme.of(context).primaryColor,
            ),
            shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
            ),
          ),
          child: SizedBox(
            height: height,
            child: centerChild
                ? Center(
                child: child ?? Text(text!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor ?? context.onPrimary,
                  ),
                )
            ) : child ?? Text(text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? context.onPrimary,
              ),
            ),
          ),
        ),
      ),
    )
        : invisiblePlaceHolder ?? const SizedBox.shrink();
  }
}
