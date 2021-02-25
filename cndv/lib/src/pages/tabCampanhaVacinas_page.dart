import 'package:cndv/src/widgets/card_campanhas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:cndv/src/services/noticias_service.dart';
import 'package:cndv/src/widgets/lista_noticias_vacinas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabCampanhaVacinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO obter dados da API de Campanhas

    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Header(
                titulo: 'Bem-vindo usuario.nome',
                subtitulo: 'Campanhas',
                icon: FontAwesomeIcons.plus,
                color1: Color(0xff526BF6),
                color2:  Color(0xff67ACF2),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Column(
                    children: <Widget>[
                      CardCampanha()
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
