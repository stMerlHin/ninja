import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kunai/kunai.dart';

void main() async {
  group("ErrorWidgetAction - en", () {
    testWidgets("onPressed - Successfully triggered",
        (WidgetTester tester) async {
      bool? pressed;

      Widget widget = Localizations(
        delegates: const [
          KunaiLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('en'),
        child: ErrorActionWidget(onPressed: () {
          pressed = true;
        }),
      );
      await tester.pumpWidget(widget);

      final Finder textButtonFinder = find.text("Retry");

      expect(textButtonFinder, findsOneWidget);

      await tester.tap(textButtonFinder);
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });

  group("ErrorWidgetAction - fr", () {
    testWidgets("onPressed - Successfully triggered",
        (WidgetTester tester) async {
      bool? pressed;

      Widget widget = Localizations(
        delegates: const [
          KunaiLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('fr'),
        child: ErrorActionWidget(onPressed: () {
          pressed = true;
        }),
      );
      await tester.pumpWidget(widget);

      final Finder textButtonFinder = find.text("Rééssayer");

      expect(textButtonFinder, findsOneWidget);

      await tester.tap(textButtonFinder);
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
