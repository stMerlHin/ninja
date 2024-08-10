import 'package:flutter/material.dart';

/// Widget which takes two Strings or Widget value and display them in a row
class RowInfo extends StatelessWidget {
  /// Create an instance of this widget with String as title and info
  const RowInfo.text({
    super.key,
    required String this.title,
    required String this.info,
    this.titleStyle,
    this.infoStyle,
    this.titleFlexible = false,
    this.flexibleContent = false,
    this.wrap = false,
    this.crossAxisAlignment,
    this.titleOverflow,
    this.descriptionOverflow,
  }) : isWidget = false;

  /// Create an instance of this widget with Widget as title and info
  const RowInfo({
    super.key,
    required Widget this.title,
    required Widget this.info,
    this.titleFlexible = false,
    this.flexibleContent = false,
    this.crossAxisAlignment,
    this.wrap = false,
  })  : isWidget = true,
        infoStyle = null,
        titleStyle = null,
        titleOverflow = null,
        descriptionOverflow = null;

  /// The info of the row info
  ///
  /// Runtime Type  can only be Widget or String depending on the constructor used
  final dynamic title;

  /// The info of the row info
  ///
  /// Runtime Type  can only be Widget or String depending on the constructor used
  final dynamic info;

  /// Tells if the title should be a child of [Flexible].
  /// Defaults to false
  final bool titleFlexible;

  /// All the content of this widget ([Row]) will be a [Flexible] child if it's
  /// set to true.
  ///
  /// Defaults to false.
  ///
  /// Very useful if this widget is a child of a Column or row.
  final bool flexibleContent;

  /// Tells if title and info are widgets
  final bool isWidget;

  /// The text style to apply to the title if the [RowInfo.text] constructor is used
  final TextStyle? titleStyle;

  /// The text style to apply to the info text if the [RowIno.text] constructor is used
  final TextStyle? infoStyle;

  final bool wrap;

  final CrossAxisAlignment? crossAxisAlignment;

  final TextOverflow? titleOverflow;
  final TextOverflow? descriptionOverflow;

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = isWidget
        ? title
        : Text(
            "$title: ",
            overflow: titleOverflow,
            style: titleStyle ??
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          );

    Widget infoWidget = isWidget
        ? info
        : Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: Text(
              info,
              overflow: descriptionOverflow,
              style: infoStyle,
            ),
          );

    Widget contentWidget = !wrap
        ? Row(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              titleFlexible ? Flexible(child: titleWidget) : titleWidget,
              Flexible(fit: FlexFit.loose, child: infoWidget)
            ],
          )
        : Wrap(
            children: [titleWidget, infoWidget],
          );

    return wrap
        ? contentWidget
        : flexibleContent
            ? Flexible(
                fit: FlexFit.loose,
                child: contentWidget,
              )
            : contentWidget;
  }
}
