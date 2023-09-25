import 'package:client_control/models/client.dart';
import 'package:flutter/material.dart';

class ClientsStore extends ChangeNotifier {
  final List<Client> _clients = [];

  ClientsStore();

  List<Client> get clients => _clients;

  void addClient(Client newClient) {
    _clients.add(newClient);
    notifyListeners();
  }

  void removeClient(int index) {
    _clients.removeAt(index);
    notifyListeners();
  }
}
