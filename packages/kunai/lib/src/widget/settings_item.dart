import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    this.color,
    required this.leftContent,
    this.rightContent,
    //this.padding,
    //this.margin,
    this.width,
    this.height,
    this.onPressed,
    this.onFocusChange,
    this.padding,
    this.onHover,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.onLongPress,
    this.style,
  });

  final double? height;
  final double? width;
  final Color? color;
  final Widget leftContent;
  final Widget? rightContent;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  //final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? context.primaryContainerColor,
      height: height ?? 60,
      child: onPressed != null
          ? TextButton(
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(
                  kButtonShape,
                ),
              ),
              onPressed: onPressed,
              child: _buildContent(),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: padding ??
          (onPressed == null
              ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
              : const EdgeInsets.all(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: leftContent),
          rightContent ?? const SizedBox()
        ],
      ),
    );
  }
}
