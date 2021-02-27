import 'package:flutter/material.dart';

class CampanhaDetalhe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Detalhes da Campanha'),
      ),
      body: Center(
        child: Text('Informação do lugar, horário, tipo vacina, info extra'),
      ),
    );
  }
}
