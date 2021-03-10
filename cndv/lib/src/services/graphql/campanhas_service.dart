import 'package:flutter/material.dart';

class CampanhasService with ChangeNotifier {
  /// TODO Service Request of Campaigns

  CampanhasService() {
    this.getCampanhas();
  }

  getCampanhas() {
    print('Carregando campanhas...');
  }
}
