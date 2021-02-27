import 'package:flutter/material.dart';

class MensagensNotificacoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6),
          title: Text('Mensagens')
      ),
      body: Center(
        child: Text('Mensagens e Notificações'),
      ),
    );
  }
}
