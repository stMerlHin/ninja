import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuriken/src/model/identified_object.dart';

void main() {
  const String id = 'id';
  final Timestamp createAt = Timestamp(0, 0);

  group("IdentifiedObject", () {
    test("Constructor initializes fields correctly", () {
      expect(const IdentifiedObject(id: id).id, id);
    });
  });

  group("TimeIdentifiedObject", () {
    test("Constructor initializes fields correctly", () {
      final t = TimeIdentifiedObject(id: id, createAt: createAt);

      expect(t.id, id);
      expect(t.createAt, createAt);
    });
  });
}
