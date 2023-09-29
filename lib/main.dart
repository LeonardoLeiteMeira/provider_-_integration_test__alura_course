import 'package:client_control/models/clientsStore.dart';
import 'package:client_control/pages/client_types_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/clientTypeStore.dart';
import 'pages/clients_page.dart';

void main({List<String> args = const [], Key providerKey = const Key("")}) =>
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientsStore()),
        ChangeNotifierProvider(create: (_) => ClientTypeStore())
      ],
      child: MyApp(
        key: providerKey,
      ),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de clientes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ClientsPage(title: 'Clients'),
        '/tipos': (context) => const ClientTypesPage(title: 'Tipos de cliente'),
      },
    );
  }
}
