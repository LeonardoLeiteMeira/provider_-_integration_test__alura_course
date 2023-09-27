// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:client_control/components/hamburger_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client_control/main.dart';

void main() {
  group("Test drawer Menu", () {
    testWidgets("Should have a Menu title", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HamburgerMenu(),
      ));
      expect(find.text("Menu"), findsOneWidget);
    });

    testWidgets("Should appear ListTile with options", (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HamburgerMenu()));
      final options = find.byType(ListTile);
      expect(options, findsAtLeastNWidgets(3));

      final clientsOption = find.widgetWithText(ListTile, "Gerenciar clientes");
      expect(clientsOption, findsOneWidget);

      final typesOption = find.widgetWithText(ListTile, "Tipos de clientes");
      expect(typesOption, findsOneWidget);

      final logoutOption = find.widgetWithText(ListTile, "Sair");
      expect(logoutOption, findsOneWidget);
    });
  });
}
