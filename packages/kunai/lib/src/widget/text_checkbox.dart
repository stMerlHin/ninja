import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCheckbox extends StatelessWidget {
  const TextCheckbox({
    Key? key,
    required this.value,
    required this.text,
    this.style,
    this.onChanged,
    this.padding,
    this.textBeforeCheckBox = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.unselectedColor,
    this.unSelectedIcon,
  }) : super(key: key);

  final bool value;
  final bool textBeforeCheckBox;
  final String text;
  final IconData? unSelectedIcon;
  final Color? unselectedColor;
  final ValueChanged<bool>? onChanged;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!value);
      },
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          textBeforeCheckBox ? _buildText() : _buildCheckbox(),
          const SizedBox(
            width: 8,
          ),
          textBeforeCheckBox ? _buildCheckbox() : _buildText(),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Flexible(
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget _buildCheckbox() {
    return Icon(
      value
          ? CupertinoIcons.checkmark_square_fill
          : unSelectedIcon ?? CupertinoIcons.square,
      color: value ? Colors.green : unselectedColor ?? Colors.grey,
    );
  }
}
