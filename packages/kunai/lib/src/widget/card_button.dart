import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';

// TODO add test for this widget
class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.title,
    required this.iconData,
    this.description = '',
    this.iconColor = const Color(0xff6750a4),
    this.iconCircleColor,
    this.titleColor,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 8,
    ),
  });

  final String title;
  final IconData iconData;
  final String description;
  final Color iconColor;
  final Color? iconCircleColor;
  final Color? titleColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                // height: 20,
                // width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: iconCircleColor ??
                      const Color(0xff545d81).withOpacity(0.4),
                ),
                padding: const EdgeInsets.all(4),
                child: Icon(
                  iconData,
                  color: iconColor,
                )),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          //height: 1.9,
                          color: titleColor ?? context.primaryColor,
                          fontFamily: "Poppins-Bold",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Text(
                      description,
                      maxLines: 2,
                      style: const TextStyle(
                        fontFamily: "Poppins-Regular",
                        fontSize: 10,
                        color: Colors.grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
