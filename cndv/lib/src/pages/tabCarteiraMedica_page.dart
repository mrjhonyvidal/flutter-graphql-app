import 'package:cndv/src/services/noticias_service.dart';
import 'package:cndv/src/widgets/headers.dart';
import 'package:cndv/src/widgets/lista_noticias_vacinas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabCarteiraMedica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO obter dados da API de Dados Pessoais e Histórico de Vacinação do cidadão
    // A modo de exemplo, estamos consumindo a API de Noticias
    final noticiasServiceHeadlines = Provider.of<NoticiasService>(context).headlines;


    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height:200.0,
              decoration: BoxDecoration(
                color: Color(0xFF03A9F4),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        alignment: Alignment.center,
                        child: Text("Conteúdo"),
                      ),
                      Container(
                        height: 300.0,
                        alignment: Alignment.center,
                        child: ListaNoticiasVacinas(noticiasServiceHeadlines),
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Entrada de dados aqui"),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        )
      ),
        //child: HeadersCircleBorder(),
      );
  }
}
