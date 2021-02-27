import 'package:flutter/material.dart';

class BuscarCampanhasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Buscar campanhas')
      ),
      body: Center(
        child: Text('Formulário com filtros para a busca de campanhas'),
      ),
    );
  }
}
