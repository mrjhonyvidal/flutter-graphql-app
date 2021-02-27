import 'package:flutter/material.dart';

class EditarDadosPessoais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Dados Pessoais')
      ),
      body: Center(
        child: Text('Formulário com dados pessoais do cidadão para editar'),
      ),
    );
  }
}
