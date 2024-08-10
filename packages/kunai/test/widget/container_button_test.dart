import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() async {
  group("ContainerButton", () {
    const String buttonText = 'button';

    testWidgets("onPressed - Successfully triggered",
        (WidgetTester tester) async {
      bool? pressed;
      Widget widget = MaterialApp(
        home: ContainerButton(
          onPressed: () {
            pressed = true;
          },
          child: const Text(buttonText),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.text(buttonText));
      await tester.pumpAndSettle();
      expect(pressed, isTrue);
    });

    testWidgets(
        "Internal text button should not show up when visibility is set to false",
        (WidgetTester tester) async {
      Widget widget = MaterialApp(
        home: ContainerButton(
          visible: false,
          onPressed: () {},
          child: const Text(buttonText),
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.text(buttonText), findsNothing);
    });

    testWidgets("Specific color is applied", (WidgetTester tester) async {
      const Color color = Colors.red;
      Widget widget = MaterialApp(
        home: ContainerButton(
          color: color,
          onPressed: () {},
          child: const Text(buttonText),
        ),
      );

      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<ContainerButton>();
      expect(values.any((element) => element.color != color), isFalse);
    });

    testWidgets("default box constraints maxWidth is 300",
        (WidgetTester tester) async {
      BoxConstraints constraints = const BoxConstraints(maxWidth: 300);
      Widget widget = MaterialApp(
        home: ContainerButton(
          color: Colors.red,
          onPressed: () {},
          child: const Text(buttonText),
        ),
      );

      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<ContainerButton>();
      expect(
          values.any((element) => element.constraints != constraints), isFalse);
    });

    testWidgets("Specific box constraints is applied",
        (WidgetTester tester) async {
      BoxConstraints constraints = const BoxConstraints(maxWidth: 100);
      Widget widget = MaterialApp(
        home: ContainerButton(
          color: Colors.red,
          constraints: constraints,
          onPressed: () {},
          child: const Text(buttonText),
        ),
      );

      await tester.pumpWidget(widget);
      final values = tester.allWidgets.whereType<ContainerButton>();
      expect(
          values.any((element) => element.constraints != constraints), isFalse);
    });
  });
}
