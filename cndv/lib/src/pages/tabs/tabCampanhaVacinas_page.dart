import 'package:cndv/src/pages/campanhas/campanha_detalhe_page.dart';
import 'package:cndv/src/pages/searchs/buscar_campanhas_page.dart';
import 'package:cndv/src/widgets/card_campanhas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cndv/src/widgets/header.dart';
import 'package:cndv/src/services/rest/noticias_service.dart';
import 'package:cndv/src/widgets/lista_noticias_vacinas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO this will be defined in our models
class CampanhaModel {
  final String texto;
  CampanhaModel(this.texto);
}

class TabCampanhaVacinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO obter campanhas a partir da API de Campanhas
    final campanhas = <CampanhaModel>[
      new CampanhaModel('Campanha 1'),
      new CampanhaModel('Campanha 2'),
      new CampanhaModel('Campanha 3'),
      new CampanhaModel('Campanha 4'),
      new CampanhaModel('Campanha 5'),
      new CampanhaModel('Campanha 6'),
    ];

    List<Widget> campanhasMap = campanhas.map(
        (campanha) => CardCampanha(
            texto: campanha.texto,
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CampanhaDetalhe()));
            },
        )
    ).toList();

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             _Header(),
              Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    color: Color(0xffF2F2F2),
                    child: Text('Sua próxima vacinação está agendada para o dia 25 de Março entre 14:00 e 15:00 no posto de saúde UBS Benedito de Oliveira Crudo, R. Carlos de Campos, 82.'),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    children: <Widget>[
                      //SizedBox( height: 80,),
                      ...campanhasMap
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

/// TODO extract this to common place as part of Header Layout as it's shared
/// between vacinas and campanhas tabCarteiraMedica
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
          Header(
          titulo: 'Próximas campanhas',
          subtitulo: 'Campanhas',
          iconHeader: FontAwesomeIcons.plus,
          color1: Color(0xff526BF6),
          color2:  Color(0xff67ACF2),
          hasLink: false,
          iconCenter: FontAwesomeIcons.calendarAlt
        ),

        Positioned(
          right: 0,
          top:15,
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15.0),
            child: FaIcon(FontAwesomeIcons.search, color: Colors.white),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BuscarCampanhasPage()));
            }
          )
        )
      ],
    );
  }
}
