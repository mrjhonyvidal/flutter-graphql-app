import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _IconHeaderBackground(),
        Positioned(
            child: Icon(Icons.add, size: 250, color: Colors.white)
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
