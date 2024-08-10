import 'package:flutter/material.dart';

// TODO test this widget
class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.title,
    required this.description,
    this.titleColor,
    this.descriptionColor,
    this.onTap,
  });

  final String title;
  final String description;
  final Color? titleColor;
  final Color? descriptionColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color c = Theme.of(context).primaryColor;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              description,
              style: TextStyle(
                color: descriptionColor ?? c,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: titleColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
