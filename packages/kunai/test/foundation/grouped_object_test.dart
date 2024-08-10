
import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() {
  const String matchingId = 'matching id';
  const String matchingId2 = 'matching id2';
  const String matchingId3 = 'matching id3';
  const String matchingId4 = 'matching id4';
  Gr gr = Gr(matchingId);
  Gr gr2 = Gr(matchingId);
  Gr gr3 = Gr(matchingId);
  Gr gr4 = Gr(matchingId2);
  Gr gr5 = Gr(matchingId2);
  Gr gr6 = Gr(matchingId3);
  Gr gr7 = Gr(matchingId4);
  Gr gr8 = Gr(matchingId4);
  Gr gr9 = Gr(matchingId4);
  GrList grList = GrList();
  GroupedObject<Gr> gp = GroupedObject(id: matchingId);
  GroupedObject<Gr> gp2 = GroupedObject(id: matchingId4);

  group("GroupedObject", () {
    test("add", () {
      gp.add(gr);
      gp.add(gr2);
      gp.add(gr3);
      gp.add(gr4);

      gp2.add(gr7);
      gp2.add(gr8);
      gp2.add(gr9);

      expect(gp.length, 3);
      expect(gp, contains(gr));
      expect(gp, contains(gr2));
      expect(gp, contains(gr3));
      expect(gp.contains(gr4), isFalse);
    });
  });

  group("GroupedObjectList", () {
    test("add", () {
      grList.add(gr);
      grList.add(gr2);
      grList.add(gr3);
      grList.add(gr4);
      grList.add(gr5);
      grList.add(gr6);

      expect(grList, contains(gr));
      expect(grList, contains(gp));
      expect(grList.length, 3);
    });

    test("addAll", () {
      grList.addAll([gp2]);

      expect(grList, contains(gp2));
      expect(grList.length, 4);
    });

    test("where", () {
      expect(
        grList.where((element) => element.matchingId == gr.matchingId).length,
        1,
      );
      expect(
        grList
            .where((element) => element.matchingId == DateTime.now().toString())
            .length,
        0,
      );
    });

    test("remove", () {
      grList.remove(gr4);
      grList.remove(gp);
      expect(grList.contains(gr4), isFalse);
      expect(grList.contains(gp), isFalse);
      expect(grList.length, 3);
    });
  });
}

class Gr implements CanBeGrouped {
  final String id;

  Gr(this.id);

  @override
  get matchingId => id;

  @override
  String toString() {
    return matchingId;
  }
}

class GrList with GroupedObjectList<Gr> {
  GrList();
}
