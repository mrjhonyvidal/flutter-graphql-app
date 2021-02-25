import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Color whiteColor = Colors.white.withOpacity(0.7);

    return Stack(
      children: <Widget>[
        _IconHeaderBackground(),
        Positioned(
            top: -50,
            left: -70,
            child: FaIcon(FontAwesomeIcons.plus, size: 250, color: Colors.white.withOpacity(0.2))
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 80, width: double.infinity),
            Text("Bem-vindo JVO", style: TextStyle(fontSize: 20, color: whiteColor)),
            SizedBox(height: 20),
            Text("Carteira Nacional Digital de Vacinação", style: TextStyle(fontSize: 20, color: whiteColor, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            FaIcon(FontAwesomeIcons.syringe, size: 50, color: Colors.white)
          ],
        )
      ],
    );
  }

}

class _IconHeaderBackground extends StatelessWidget {
  const _IconHeaderBackground({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff526BF6),
            Color(0xff67ACF2)
          ]
        )
      ),
    );
  }
}
