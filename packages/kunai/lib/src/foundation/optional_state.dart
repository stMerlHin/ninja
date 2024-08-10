import 'package:flutter/cupertino.dart';

abstract class OptionalState<T extends StatefulWidget> extends State {
  /// Call setState only if the widget is still mounted on
  /// the widget tree so it can be called after dispose, nothing will
  /// happen
  void setConditionalState(VoidCallback fn, {VoidCallback? onStateDetached}) {
    if (mounted) {
      setState(fn);
    } else if (onStateDetached != null) {
      //fn.call();
      onStateDetached();
    }
  }

  void lateAction() {}

  @override
  T get widget => _getWidget();

  _getWidget() {
    return super.widget;
  }
}
