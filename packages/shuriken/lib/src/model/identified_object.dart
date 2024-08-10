import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kunai/kunai.dart';

class IdentifiedObject with Mappable implements CanBeGrouped {
  final dynamic id;

  const IdentifiedObject({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap([bool store = true]) {
    return {};
  }

  @override
  // TODO: implement matchingId
  get matchingId => id;
}

class TimeIdentifiedObject extends IdentifiedObject {
  final Timestamp createAt;

  const TimeIdentifiedObject({
    required super.id,
    required this.createAt,
  });
}
