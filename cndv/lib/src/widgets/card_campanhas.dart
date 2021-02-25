import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardCampanha extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: <Widget>[
        _CardCampanhaBackground(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox( height: 140, width: 40),
            Expanded(
              child: Text('Campanha 1', style: TextStyle( color: Colors.white, fontSize: 18), ),
            ),
            FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
            SizedBox(width: 40),
          ],
        )
      ],
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: 0,
                top: 0,
                child: FaIcon(FontAwesomeIcons.syringe, size: 100, color: Colors.white.withOpacity(0.2))
            )
          ],
        ),
      ),
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(4,6), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF6989F5),
            Color(0xff67ACF2),
          ]
        )
      )
    );
  }
}

