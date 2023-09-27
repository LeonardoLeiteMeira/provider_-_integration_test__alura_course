import 'dart:math';

import 'package:client_control/models/client.dart';
import 'package:client_control/models/clientTypeStore.dart';
import 'package:client_control/models/client_type.dart';
import 'package:client_control/models/clientsStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var clientType = ClientType(icon: Icons.ac_unit, name: "IconTest");
  var client =
      Client(name: "Leonardo Leite", email: "leo@email.com", type: clientType);

  var clientStore = ClientsStore();
  clientStore.addClient(client);
  clientStore.addClient(client);

  var typeStore = ClientTypeStore();
  typeStore.addClientType(clientType);
  typeStore.addClientType(clientType);
  group("Client Tests", () {
    test("Add Clients", () {
      expect(clientStore.clients, [client, client]);
    });

    test('Remove clients', () {
      clientStore.removeClient(0);
      expect(clientStore.clients, [client]);
    });
  });

  group("Type test", () {
    test("Add type", () {
      expect(typeStore.clientTypes.length, 6);
    });
    test("Remove type", () {
      typeStore.removeClientType(0);
      expect(typeStore.clientTypes.length, 5);
    });
  });
}
