import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:cndv/src/services/noticias_service.dart';
import 'package:cndv/src/widgets/lista_noticias_vacinas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            _Header(),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: <Widget>[

                      Container(
                        height: 300.0,
                        padding: EdgeInsets.symmetric(vertical: 30.0),
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.center,
                        child: ListaNoticiasVacinas(noticiasServiceHeadlines),
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

/// TODO extract this to common place as part of Header Layout
/// as it's shared between vacinas and campanhas tabCampanhaVacinas
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Header(
          titulo: 'Bem-vindo usuario.nome',
          subtitulo: 'Carteira Nacional Digital de Vacinação',
          username: 'JVO',
          icon: FontAwesomeIcons.plus,
          color1: Color(0xff526BF6),
          color2:  Color(0xff67ACF2),
        ),
        Positioned(
            right: 0,
            top:15,
            child: RawMaterialButton(
                onPressed: (){},
                shape: CircleBorder(),
                padding: EdgeInsets.all(15.0),
                child: FaIcon(FontAwesomeIcons.ellipsisV, color: Colors.white)
            )
        )
      ],
    );
  }
}

