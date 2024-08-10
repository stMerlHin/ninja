import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() {
  group("RowInfo", () {
    Widget widget = MaterialApp(
      home: RowInfo(title: Container(), info: Container()),
    );

    testWidgets("title's type should be Widget", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<RowInfo>();

      expect(values.any((element) => element.title is! Widget), false);
    });

    testWidgets("info's type should be Widget", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<RowInfo>();

      expect(values.any((element) => element.info is! Widget), false);
    });

    testWidgets("info is a child of Flexible", (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(Flexible), findsOneWidget);
    });

    testWidgets(
        "content of rowInfo is a child of Flexible when contentFlexible is set to true",
        (WidgetTester tester) async {
      Widget widget = MaterialApp(
        home: Column(
          children: [
            RowInfo(
                flexibleContent: true, title: Container(), info: Container()),
          ],
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(Flexible), findsNWidgets(2));
    });
  });

  group("RowInfo.text", () {
    Widget widget = const MaterialApp(
      home: RowInfo.text(title: 'Title', info: 'Info'),
    );

    testWidgets("title's type should be String", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<RowInfo>();

      expect(values.any((element) => element.title is! String), false);
    });

    testWidgets("info's type should be String", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<RowInfo>();

      expect(values.any((element) => element.info is! String), false);
    });

    testWidgets("info's widget is a child of Flexible",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(Flexible), findsOneWidget);
    });

    testWidgets(
        "content of rowInfo is a child of Flexible when contentFlexible is set to true",
        (WidgetTester tester) async {
      Widget widget = MaterialApp(
        home: Column(
          children: [
            RowInfo(
                flexibleContent: true, title: Container(), info: Container()),
          ],
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(Flexible), findsNWidgets(2));
    });
  });
}
