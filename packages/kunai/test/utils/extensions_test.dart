import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() {
  DateTime date = DateTime(2023, 1, 31);
  DateTime date2 = DateTime(2023, 1, 23);
  DateTime date3 = DateTime(2023, 1, 29);
  DateTime date4 = DateTime(2023, 12, 14);
  //
  // print(date.plusMonth(0));

  group("DateTimeExt", () {
    test("plusMonth", () {
      expect(date.plusMonth(2), date.copyWith(month: 3));
      expect(date.plusMonth(14), date.copyWith(year: 2024, month: 3));
      // Test for December bug
      expect(date4.plusMonth(1), date4.copyWith(year: 2024, month: 1));
    });

    test('lastWeekFirstDayDate', () {
      expect(date.lastWeekFirstDayDate.day, 23);
      expect(date2.lastWeekFirstDayDate.day, 16);
      expect(date3.lastWeekFirstDayDate.day, 16);
    });

    test("<, == and > operator", () {
      expect(date < date.add(const Duration(microseconds: 1)), isTrue);
      expect(date > date.subtract(const Duration(microseconds: 1)), isTrue);
      expect(date == date.copyWith(), isTrue);
    });
  });

  test("List extension", () {
    List<int> ri = [];
    for (int i = 0; i < 21; i++) {
      ri.add(i);
    }
    expect(ri.split(20).length, 2);
  });
}
