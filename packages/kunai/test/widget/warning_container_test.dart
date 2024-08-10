import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() {
  group('Warning container field test', () {
    testWidgets("specified Warning container color is applied",
        (WidgetTester tester) async {
      Widget widget = const MaterialApp(
        home: WarningContainer(
          message: "This is a message",
          color: Colors.red,
        ),
      );

      await tester.pumpWidget(widget);
      Iterable<WarningContainer> warnings =
          tester.allWidgets.whereType<WarningContainer>();
      expect(warnings.any((element) => element.color != Colors.red), isFalse);
    });

    testWidgets("specified Warning container border radius is applied",
        (WidgetTester tester) async {
      Widget widget = MaterialApp(
        home: WarningContainer(
          message: "This is a message",
          borderRadius: BorderRadius.circular(90),
        ),
      );

      await tester.pumpWidget(widget);
      Iterable<WarningContainer> warnings =
          tester.allWidgets.whereType<WarningContainer>();
      expect(
          warnings.any(
              (element) => element.borderRadius != BorderRadius.circular(90)),
          isFalse);
    });

    testWidgets("specified Warning container padding is applied",
        (WidgetTester tester) async {
      Widget widget = const MaterialApp(
        home: WarningContainer(
          message: "This is a message",
          padding: EdgeInsets.all(0),
        ),
      );

      await tester.pumpWidget(widget);
      Iterable<WarningContainer> warnings =
          tester.allWidgets.whereType<WarningContainer>();
      expect(
          warnings.any((element) => element.padding != const EdgeInsets.all(0)),
          isFalse);
    });

    testWidgets("specified Warning container margin is applied",
        (WidgetTester tester) async {
      Widget widget = const MaterialApp(
        home: WarningContainer(
          message: "This is a message",
          margin: EdgeInsets.all(20),
        ),
      );

      await tester.pumpWidget(widget);
      Iterable<WarningContainer> warnings =
          tester.allWidgets.whereType<WarningContainer>();
      expect(
          warnings.any((element) => element.margin != const EdgeInsets.all(20)),
          isFalse);
    });

    testWidgets("specified Warning container text style is applied",
        (WidgetTester tester) async {
      Widget widget = const MaterialApp(
        home: WarningContainer(
          message: "This is a message",
          textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        ),
      );

      await tester.pumpWidget(widget);
      Iterable<WarningContainer> warnings =
          tester.allWidgets.whereType<WarningContainer>();
      expect(
          warnings.any((element) =>
              element.textStyle !=
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
          isFalse);
    });
  });
}
