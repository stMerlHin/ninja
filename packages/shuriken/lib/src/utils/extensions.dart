import 'package:cloud_firestore/cloud_firestore.dart';

extension DateTimeStampExt on DateTime {

  Timestamp get timestamp {
    return Timestamp.fromMicrosecondsSinceEpoch(toUtc().microsecondsSinceEpoch);
  }
}