import 'package:flutter/material.dart';

class CarteiraCidadaoService with ChangeNotifier {
  /// TODO Here is going to have all the API calls to have our
  /// Citizen Medical Profile composed by Historial of Vacines, Profile data

  CarteiraCidadaoService() {
    this.getVacineHistorial();
  }

  getVacineHistorial() {
    print('Carregando vacinas do cidadão...');
  }
}
