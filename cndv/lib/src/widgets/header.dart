import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget {

  final IconData icon;
  final String username; // TODO this should be an instance of Usuario/Cidadao
  final String titulo;
  final String subtitulo;
  final Color color1;
  final Color color2;

  const Header({
    @required this.titulo,
    @required this.subtitulo,
    this.icon = FontAwesomeIcons.plus,
    this.username = '',
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey
  });

  @override
  Widget build(BuildContext context) {
    final Color whiteColor = Colors.white.withOpacity(0.7);

    return Stack(
      children: <Widget>[
        _IconHeaderBackground(
          color1: this.color1,
          color2: this.color2,
        ),
        Positioned(
            top: -50,
            left: -70,
            child: FaIcon(this.icon, size: 250, color: Colors.white.withOpacity(0.2))
        ),
        Column(
          children: <Widget>[
            SizedBox(height: 80, width: double.infinity),
            Text(this.titulo, style: TextStyle(fontSize: 20, color: whiteColor)),
            SizedBox(height: 20),
            Text(this.subtitulo, style: TextStyle(fontSize: 20, color: whiteColor, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            FaIcon(this.username.isEmpty ? FontAwesomeIcons.calendarAlt : FontAwesomeIcons.idCard, size: 60, color: Colors.white)
          ],
        )
      ],
    );
  }

}

class _IconHeaderBackground extends StatelessWidget {

  final Color color1;
  final Color color2;

  const _IconHeaderBackground({
    Key key,
    @required this.context,
    this.color1,
    this.color2,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            this.color1,
            this.color2
          ]
        )
      ),
    );
  }
}
