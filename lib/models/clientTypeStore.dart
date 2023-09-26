import 'package:flutter/material.dart';

import 'client_type.dart';

class ClientTypeStore extends ChangeNotifier {
  final List<ClientType> _clientTypes = [];

  ClientTypeStore() {
    _clientTypes.addAll([
      ClientType(name: 'Platinum', icon: Icons.credit_card),
      ClientType(name: 'Golden', icon: Icons.card_membership),
      ClientType(name: 'Titanium', icon: Icons.credit_score),
      ClientType(name: 'Diamond', icon: Icons.diamond),
    ]);
  }

  List<ClientType> get clientTypes => _clientTypes;

  void addClientType(ClientType newClientType) {
    _clientTypes.add(newClientType);
    notifyListeners();
  }

  void removeClientType(int index) {
    _clientTypes.removeAt(index);
    notifyListeners();
  }
}
