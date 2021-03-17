import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MensagensNotificacoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final contentFromArguments = (ModalRoute.of(context).settings.arguments) ?? 'Nenhuma mensagem recebida.';

    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff526BF6), title: Text('Mensagens')),
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Icon(Icons.campaign_outlined, size: 40),
              ),
            TextSpan(
                text: contentFromArguments,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
