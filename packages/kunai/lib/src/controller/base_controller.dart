import 'package:flutter/foundation.dart';

abstract class BaseController {
  bool loadingData = true;
  bool errorLoadingData = false;
  VoidCallback onDataChanged = () {};
  VoidCallback notifyParent = () {};
  bool _parentDisposed = false;

  Future<void> init() async {
    await loadData();
  }

  Future<void> loadData([bool notify = true]) async {
    if (notify) {
      loadingData = true;
      errorLoadingData = false;
      onDataChanged();
    }
  }

  void setError() {
    loadingData = false;
    errorLoadingData = true;
    onDataChanged();
  }

  void setLoading() {
    loadingData = true;
    errorLoadingData = false;
    onDataChanged();
  }

  void dispose() {
    onDataChanged = () {};
  }

  @mustCallSuper
  void parentDispose() {
    loadingData = true;
    errorLoadingData = false;
    notifyParent = () {};
    if (!_parentDisposed) {
      dispose();
    }
    _parentDisposed = true;
  }
}
