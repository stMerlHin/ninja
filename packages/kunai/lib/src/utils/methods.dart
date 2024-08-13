import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kunai/kunai.dart';
import 'package:kunai/l10n/localizations_ext.dart';



typedef ValueCallback<T> = void Function(T value);
typedef DoubleValueCallback<T, U> = void Function(T value, U val);
typedef TripleValueCallback<T, U, V> = void Function(T value, U val, V);
typedef FutureCallback<T> = Future<void> Function(T value);
typedef VoidFutureCallback = Future<void> Function();

// Launch new page
Future nextPage(BuildContext context, Widget page,
    {bool replace = false}) async {
  if (context.mounted) {
    if (replace) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }),
      );
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return page;
      }),
    );
  }
}

Color themePrimaryColor(BuildContext context) {
  return Theme.of(context).primaryColor;
}
//
// void openStore(AppName appName) async {
//   if (Platform.isAndroid || Platform.isIOS) {
//     // TODO set the iOS app id later
//     String appId =
//         Platform.isAndroid ? appName.androidPackageName() : 'YOUR_IOS_APP_ID';
//     final url = Uri.parse(
//       Platform.isAndroid
//           ? "https://play.google.com/store/apps/details?id=$appId"
//           : "https://apps.apple.com/app/id$appId",
//     );
//     launchUrl(
//       url,
//       mode: LaunchMode.externalApplication,
//     );
//   }
// }

String md5Hash(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

///Go back to the previous page
void previousPage(BuildContext context) async {
  if (context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> settle({
  Duration duration = const Duration(milliseconds: 2),
}) async {
  await Future.delayed(duration);
}

// Future si() async {
//   LocalNotification notification = LocalNotification(
//     title: "Nouveaute",
//     body: "hello flutter!",
//   );
//
//   notification.onClose = (closeReason) {
//     // Only supported on windows, other platforms closeReason is always unknown.
//     switch (closeReason) {
//       case LocalNotificationCloseReason.userCanceled:
//       // do something
//         break;
//       case LocalNotificationCloseReason.timedOut:
//       // do something
//         break;
//       default:
//     }
//     print('onClose ${notification.identifier} - $closeReason');
//   };
//   notification.onClick = () {
//     print('onClick ${notification.identifier}');
//   };
//   notification.onClickAction = (actionIndex) {
//     print('onClickAction ${notification.identifier} - $actionIndex');
//   };
//   await Future.delayed(Duration(seconds: 4));
//   notification.show();
// }

// Show a snackBar with 2 seconds as duration
Future<void> snackBar(
  BuildContext context,
  String message, {
  int durationSeconds = 2,
}) async {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationSeconds),
      ),
    );
  }
  return;
}

List<String> dynamicListToStringList(List<dynamic>? list) {
  List<String> m = [];
  if (list != null) {
    m = [...list];
  }
  return m;
}

Widget infoBox({
  required String title,
  required String content,
  VoidCallback? onTap,
  EdgeInsetsGeometry padding = const EdgeInsets.all(20),
  EdgeInsetsGeometry margin = const EdgeInsets.symmetric(
    horizontal: 5,
    vertical: 20,
  ),
}) {
  return GestureDetector(
    //splashColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 30,
            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      ),
      // width: 200,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )
        ].center(),
      ),
    ),
  );
}

// Show a snackBar with 2 seconds as duration
showConnexionErrorSnackBar(BuildContext context, {int durationSeconds = 2}) {
  if (context.mounted) {
    return snackBar(
        context,
        "${context.kunaiL10n.anErrorHappened} "
        "${context.kunaiL10n.checkYourConnection.toLowerCase()} "
        "${context.kunaiL10n.and} ${context.kunaiL10n.ppRetry.toLowerCase()}");
  }
}

SizedBox preferredSizedBox({double height = 20}) {
  return SizedBox(
    height: height,
  );
}

// Future si() async {
//   LocalNotification notification = LocalNotification(
//     title: "Nouveaute",
//     body: "hello flutter!",
//   );
//
//   notification.onClose = (closeReason) {
//     // Only supported on windows, other platforms closeReason is always unknown.
//     switch (closeReason) {
//       case LocalNotificationCloseReason.userCanceled:
//       // do something
//         break;
//       case LocalNotificationCloseReason.timedOut:
//       // do something
//         break;
//       default:
//     }
//     print('onClose ${notification.identifier} - $closeReason');
//   };
//   notification.onClick = () {
//     print('onClick ${notification.identifier}');
//   };
//   notification.onClickAction = (actionIndex) {
//     print('onClickAction ${notification.identifier} - $actionIndex');
//   };
//   await Future.delayed(Duration(seconds: 4));
//   notification.show();
// }

// String parseMonth(int? value) {
//   switch (value) {
//     case DateTime.january:
//       return "Janvier";
//     case DateTime.february:
//       return "Fevrier";
//     case DateTime.march:
//       return "Mars";
//     case DateTime.april:
//       return "Avril";
//     case DateTime.may:
//       return "Mai";
//     case DateTime.june:
//       return "Juin";
//     case DateTime.july:
//       return "Juillet";
//     case DateTime.august:
//       return "Aout";
//     case DateTime.september:
//       return "Septembre";
//     case DateTime.october:
//       return "Octobre";
//     case DateTime.november:
//       return "Novembre";
//     case DateTime.december:
//       return "December";
//     default:
//       return "";
//   }
// }
//
// String parseDay(int? value) {
//   switch (value) {
//     case 1:
//       return 'Lundi';
//     case 2:
//       return 'Mardi';
//     case 3:
//       return 'Mercredi';
//     case 4:
//       return 'Jeudi';
//     case 5:
//       return 'Vendredi';
//     case 6:
//       return 'Samedi';
//     case 7:
//       return 'Dimanche';
//     default:
//       return '';
//   }
// }

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

Widget normalField({text}) {
  return SizedBox(
    height: 70,
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          hintStyle: const TextStyle(color: Colors.black26),
          hintText: text,
          fillColor: Colors.white),
    ),
  );
}

/// Shows a modal material design bottom sheet with close button on top.
///
/// A modal bottom sheet is an alternative to a menu or a dialog and prevents
/// the user from interacting with the rest of the app.
///
/// A closely related widget is a persistent bottom sheet, which shows
/// information that supplements the primary content of the app without
/// preventing the user from interacting with the app. Persistent bottom sheets
/// can be created and displayed with the [showBottomSheet] function or the
/// [ScaffoldState.showBottomSheet] method.
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the bottom sheet. It is only used when the method is called. Its
/// corresponding widget can be safely removed from the tree before the bottom
/// sheet is closed.
///
/// The `isScrollControlled` parameter specifies whether this is a route for
/// a bottom sheet that will utilize [DraggableScrollableSheet]. If you wish
/// to have a bottom sheet that has a scrollable child such as a [ListView] or
/// a [GridView] and have the bottom sheet be draggable, you should set this
/// parameter to true.
///
/// The `useRootNavigator` parameter ensures that the root navigator is used to
/// display the [BottomSheet] when set to `true`. This is useful in the case
/// that a modal [BottomSheet] needs to be displayed above all other content
/// but the caller is inside another [Navigator].
///
/// The [isDismissible] parameter specifies whether the bottom sheet will be
/// dismissed when user taps on the scrim.
///
/// The [enableDrag] parameter specifies whether the bottom sheet can be
/// dragged up and down and dismissed by swiping downwards.
///
/// The optional [backgroundColor], [elevation], [shape], [clipBehavior],
/// [constraints] and [transitionAnimationController]
/// parameters can be passed in to customize the appearance and behavior of
/// modal bottom sheets (see the documentation for these on [BottomSheet]
/// for more details).
///
/// The [closeButtonBackground] define the background color of the close button
///
/// The [closeButtonIcon] is the icon of the top close button. Default to
/// [CupertinoIcons.multiply]
///
/// The [closeButtonSize] is the size of the close button. Default to 50.0
///
/// The [content] is the main content to show.
///
/// The [transitionAnimationController] controls the bottom sheet's entrance and
/// exit animations. It's up to the owner of the controller to call
/// [AnimationController.dispose] when the controller is no longer needed.
///
/// The optional `routeSettings` parameter sets the [RouteSettings] of the modal bottom sheet
/// sheet. This is particularly useful in the case that a user wants to observe
/// [PopupRoute]s within a [NavigatorObserver].
///
/// {@macro flutter.widgets.RawDialogRoute}
///
/// Returns a `Future` that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the modal bottom sheet was closed.
///
/// {@tool dartpad}
/// This example demonstrates how to use `showModalBottomSheet` to display a
/// bottom sheet that obscures the content behind it when a user taps a button.
/// It also demonstrates how to close the bottom sheet using the [Navigator]
/// when a user taps on a button inside the bottom sheet.
///
/// ** See code in examples/api/lib/material/bottom_sheet/show_modal_bottom_sheet.0.dart **
/// {@end-tool}
///
/// See also:
///
///  * [BottomSheet], which becomes the parent of the widget returned by the
///    function passed as the `builder` argument to [showModalBottomSheet].
///  * [showBottomSheet] and [ScaffoldState.showBottomSheet], for showing
///    non-modal bottom sheets.
///  * [DraggableScrollableSheet], which allows you to create a bottom sheet
///    that grows and then becomes scrollable once it reaches its maximum size.
///  * [DisplayFeatureSubScreen], which documents the specifics of how
///    [DisplayFeature]s can split the screen into sub-screens.
///  * <https://material.io/design/components/sheets-bottom.html#modal-bottom-sheet>
Future<void> showClosableModalSheet<T>({
  required BuildContext context,
  required Widget content,
  Color? backgroundColor,
  Icon? closeButtonIcon,
  Color? closeButtonBackground,
  double? elevation,
  VoidCallback? onCloseButtonTaped,
  ShapeBorder? shape,
  Clip? clipBehavior,
  double? closeButtonSize,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool applyFlex = true,
  int flex = 1,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  double? radius,
  BoxDecoration? decoration,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
  VoidCallback? onDismissed,
}) async {
  await showModalBottomSheet(
      context: context,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      elevation: 0,
      anchorPoint: anchorPoint,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      builder: (c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(closeButtonSize ?? 50),
              child: Container(
                  height: closeButtonSize ?? 50,
                  width: closeButtonSize ?? 50,
                  color: closeButtonBackground ?? Colors.white,
                  child: IconButton(
                      onPressed: onCloseButtonTaped ??
                          () {
                            previousPage(context);
                          },
                      icon: closeButtonIcon ??
                          const Icon(CupertinoIcons.multiply))),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              flex: applyFlex ? flex : 0,
              child: Container(
                  width: double.infinity,
                  decoration: decoration ??
                      BoxDecoration(
                        color: backgroundColor ?? Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius ?? 15),
                            topRight: Radius.circular(radius ?? 15)),
                      ),
                  child: content),
            ),
          ],
        );
      });
  onDismissed?.call();
}

Future newPage(BuildContext context, Widget page) async {
  await Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

Future<void> showProgressDialog({
  required BuildContext context,
  Widget? title,
  bool barrierDismissible = false,
  Widget? description,
  Color? surfaceTintColor = Colors.white,
  void Function()? onDismiss,
}) async {
  await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (c) {
        return AlertDialog(
          title: title,
          surfaceTintColor: surfaceTintColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              description ?? const SizedBox.shrink(),
              const SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(child: CircularProgressIndicator())),
            ],
          ),
        );
      });
  onDismiss?.call();
}

Future<void> showAlertDialog({
  required BuildContext context,
  Widget? title,
  Widget? content,
  Color? surfaceTintColor = Colors.white,
  List<Widget>? actions,
  bool barrierDismissible = false,
  void Function()? onDismiss,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (c) {
      return AlertDialog(
        title: title,
        surfaceTintColor: surfaceTintColor,
        content: content,
        actions: actions,
      );
    },
  );
  onDismiss?.call();
}

Future<void> showWarningDialog({
  required BuildContext context,
  required String contentText,
  required VoidCallback onContinuePressed,
  String? validateText,
  String? cancelText,
}) async {
  showAlertDialog(
      context: context,
      barrierDismissible: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.warning_rounded,
              size: 50,
              color: Colors.orange,
            ),
          ),
          Center(
            child: Text(
              contentText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => previousPage(context),
          child: Text(cancelText ?? context.kunaiL10n.cancel),
        ),
        TextButton(
          onPressed: () async {
            // close this dialog
            previousPage(context);
            onContinuePressed();
          },
          child: Text(
            validateText ?? context.kunaiL10n.continueT,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ]);
}

Widget mdpField({text}) {
  return SizedBox(
    height: 70,
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        hintStyle: const TextStyle(color: Colors.black26),
        hintText: text,
        fillColor: Colors.white,
      ),
    ),
  );
}
