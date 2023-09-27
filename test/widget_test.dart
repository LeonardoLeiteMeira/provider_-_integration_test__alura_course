// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:client_control/components/hamburger_menu.dart';
import 'package:client_control/components/icon_picker.dart';
import 'package:client_control/models/clientTypeStore.dart';
import 'package:client_control/pages/client_types_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:client_control/main.dart';
import 'package:provider/provider.dart';

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

  group("Test IconPicker", () {
    testWidgets('Should show close option', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider.value(
        value: ClientTypeStore(),
        child: const MaterialApp(
            home: ClientTypesPage(
          title: 'Test',
        )),
      ));
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      final dialog = find.byType(AlertDialog);
      expect(dialog, findsOneWidget);

      final selectIconButton =
          find.widgetWithText(ElevatedButton, "Selecionar icone");
      expect(selectIconButton, findsOneWidget);
      await tester.tap(selectIconButton);

      await tester.pumpAndSettle();

      final iconDialog = find.widgetWithText(AlertDialog, "Escolha um ícone");
      expect(iconDialog, findsOneWidget);

      final iconsOptions = find.byType(IconButton);
      expect(iconsOptions, findsWidgets);

      final closeButton = find.widgetWithText(ElevatedButton, "Fechar");
      expect(closeButton, findsOneWidget);
    });
  });
}
