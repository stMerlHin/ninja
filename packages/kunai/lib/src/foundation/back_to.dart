import 'package:flutter/foundation.dart';

mixin BackTo {
  Future<void> Function() backToRootPage = () async {};
}
//
// mixin UserChanged on BaseDataController {
//   late User _user;
//
//   @mustCallSuper
//   void setUser(User user) {
//     _user = user;
//     onDataChanged();
//   }
//
//   User get user => _user;
// }
