import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'separator.dart';

class NotificationBox extends StatelessWidget {
  const NotificationBox({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    this.pinned = false,
    this.padding = const EdgeInsets.all(8.0),
    this.margin = const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
    this.color,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  final String title;
  final String body;
  final String date;
  final Color? color;
  final bool pinned;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      child: Container(
        padding: padding,
        margin: margin,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: color ?? Theme.of(context).primaryColor,
                  ),
                ),
                pinned
                    ? const Icon(
                        CupertinoIcons.pin_fill,
                        color: Colors.red,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Separator(
              color: Colors.grey.withOpacity(0.5),
            ),
            Text(
              date,
              style:
                  TextStyle(fontSize: 11, color: Colors.grey.withOpacity(0.7)),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              body,
            ),
          ],
        ),
      ),
    );
  }
}
