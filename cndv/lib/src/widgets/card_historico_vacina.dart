import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardHistoricoVacina extends StatelessWidget {

  @required final String tipo_vacina;
  @required final Function onPress;

  const CardHistoricoVacina({
    Key key,
    this.tipo_vacina,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Stack (
        children: <Widget>[
          _CardCampanhaBackground(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox( height: 140, width: 40),
              Expanded(
                child: Stack(
                  children: <Widget>[
                      Text(tipo_vacina, style: TextStyle( color: Colors.black, fontSize: 16), ),
                  ],
                ),
              ),
              FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _CardCampanhaBackground extends StatelessWidget {

  const _CardCampanhaBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(4,6), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(5),
      )
    );
  }
}

