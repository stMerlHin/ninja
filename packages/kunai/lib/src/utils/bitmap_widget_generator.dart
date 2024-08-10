import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

/// This just adds overlay and builds [_BitmapWidgetHelper] on that overlay.
/// [_BitmapWidgetHelper] does all the heavy work of creating and getting bitmaps
class BitmapWidgetGenerator {
  final Function(List<Uint8List>) callback;
  final List<Widget> markerWidgets;

  BitmapWidgetGenerator(this.markerWidgets, this.callback);

  void generate(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);

    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) {
        return _BitmapWidgetHelper(
          markerWidgets: markerWidgets,
          callback: (List<Uint8List> bitmapList) {
            // Given callback function
            callback.call(bitmapList);

            // Remove marker widget stack from Overlay when finished
            entry?.remove();
          },
        );
      },
      maintainState: true,
    );

    overlayState.insert(entry);
  }
}

/// This widget drawn Widget to bitmap and
///
/// 1) It draws widget to tree
/// 2) After painted access the repaint boundary with global key and converts it to uInt8List
/// 3) Returns set of Uint8List (bitmaps) through callback
class _BitmapWidgetHelper extends StatefulWidget {
  final List<Widget> markerWidgets;
  final Function(List<Uint8List>) callback;

  const _BitmapWidgetHelper({
    required this.markerWidgets,
    required this.callback,
  });

  @override
  _BitmapWidgetHelperState createState() => _BitmapWidgetHelperState();
}

class _BitmapWidgetHelperState extends State<_BitmapWidgetHelper>
    with AfterLayoutMixin {
  List<GlobalKey> globalKeys = [];

  @override
  void afterFirstLayout(BuildContext context) {
    _getBitmaps(context).then((list) {
      widget.callback(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(MediaQuery.of(context).size.width, 0),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: widget.markerWidgets.map((i) {
            final markerKey = GlobalKey();
            globalKeys.add(markerKey);
            return RepaintBoundary(
              key: markerKey,
              child: i,
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary =
        markerKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}

/// AfterLayoutMixin
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}
