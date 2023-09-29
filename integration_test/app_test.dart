import 'package:client_control/models/clientTypeStore.dart';
import 'package:client_control/models/client_type.dart';
import 'package:client_control/models/clientsStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Integration test", (tester) async {
    const newType = "Leonardo Type";
    const newClientName = "Leonardo Client";
    const newClientEmail = "leo@email.com";
    const newTypeIcon = Icons.card_giftcard;

    final myProviderKey = GlobalKey();

    app.main(providerKey: myProviderKey);

    await tester.pumpAndSettle();
    expect(find.text("Clients"), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text("Menu"), findsOneWidget);
    expect(find.text("Gerenciar clientes"), findsOneWidget);
    expect(find.text("Tipos de clientes"), findsOneWidget);
    expect(find.text("Sair"), findsOneWidget);

    await tester.tap(find.text("Tipos de clientes"));
    await tester.pumpAndSettle();

    expect(find.text("Tipos de cliente"), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text("Platinum"), findsOneWidget);
    expect(find.text("Golden"), findsOneWidget);
    expect(find.text("Titanium"), findsOneWidget);
    expect(find.text("Diamond"), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    final typeNameTextField = find.byType(TextField);
    expect(typeNameTextField, findsOneWidget);

    await tester.enterText(typeNameTextField, newType);

    final selectIconsButton =
        find.widgetWithText(ElevatedButton, "Selecionar icone");
    expect(selectIconsButton, findsOneWidget);

    await tester.tap(selectIconsButton);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(newTypeIcon));
    await tester.pumpAndSettle();

    final saveButton = find.widgetWithText(TextButton, "Salvar");
    expect(saveButton, findsOneWidget);

    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    // Testando se o novo tipo de cliente esta no provider
    expect(
        Provider.of<ClientTypeStore>(myProviderKey.currentContext!,
                listen: false)
            .clientTypes
            .last
            .name,
        newType);

    expect(
        Provider.of<ClientTypeStore>(myProviderKey.currentContext!,
                listen: false)
            .clientTypes
            .last
            .icon,
        newTypeIcon);

    final clientTypeAdded = find.widgetWithText(Dismissible, newType);
    expect(clientTypeAdded, findsOneWidget);
    expect(find.byIcon(newTypeIcon), findsOneWidget);

    //Testar novo tipo de cliente
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Gerenciar clientes"));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text("Cadastrar cliente"), findsOneWidget);

    final clientNameTextField =
        find.widgetWithIcon(TextFormField, Icons.account_box);
    expect(clientNameTextField, findsOneWidget);
    final emailTextField = find.widgetWithIcon(TextFormField, Icons.email);
    expect(emailTextField, findsOneWidget);

    await tester.enterText(clientNameTextField, newClientName);
    await tester.enterText(emailTextField, newClientEmail);

    final clientTypeSelection = find.byType(DropdownButton<ClientType>);
    expect(clientTypeSelection, findsOneWidget);
    await tester.tap(clientTypeSelection);
    await tester.pumpAndSettle();

    final newTypeToSelect = find
        .text(newType)
        .last; //O DropdownButton cria duas camadas na arvore de widget, e por isso devemos pegar o ultimo
    expect(newTypeToSelect, findsOneWidget);
    await tester.tap(newTypeToSelect);
    await tester.pumpAndSettle();

    final saveButtonNewClient = find.widgetWithText(TextButton, "Salvar");
    expect(saveButtonNewClient, findsOneWidget);
    await tester.tap(saveButtonNewClient);
    await tester.pumpAndSettle();

    final newClientWithIcon =
        find.widgetWithText(Dismissible, "$newClientName ($newType)");
    expect(newClientWithIcon, findsOneWidget);

    final checkText = find.byIcon(newTypeIcon);
    expect(checkText, findsOneWidget);

    //Testando se o cliente ta no provider
    expect(
        Provider.of<ClientsStore>(myProviderKey.currentContext!, listen: false)
            .clients
            .last
            .name,
        newClientName);
    expect(
        Provider.of<ClientsStore>(myProviderKey.currentContext!, listen: false)
            .clients
            .last
            .email,
        newClientEmail);

    final sizeOfClientListWithNewClient =
        Provider.of<ClientsStore>(myProviderKey.currentContext!, listen: false)
            .clients
            .length;

    // Apagar usuario tester.drag
    await tester.drag(newClientWithIcon, const Offset(500, 0));
    await tester.pumpAndSettle();

    final deletedClientWithIcon =
        find.widgetWithText(Dismissible, "$newClientName ($newType)");
    expect(deletedClientWithIcon, findsNothing);

    //Verificar se apagou do provider
    expect(
        Provider.of<ClientsStore>(myProviderKey.currentContext!, listen: false)
            .clients
            .length,
        sizeOfClientListWithNewClient - 1);

    //Sair do app
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    final logoutButton = find.text("Sair");
    expect(logoutButton, findsOneWidget);
    // await tester.tap(logoutButton);
    // await tester.pumpAndSettle();
  });
}
