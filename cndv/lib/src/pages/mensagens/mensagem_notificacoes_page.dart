import 'package:flutter/material.dart';

class MensagensNotificacoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final contentFromArguments = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff526BF6), title: Text('Mensagens')),
      body: Center(
        child: Text(contentFromArguments),
      ),
    );
  }
}
