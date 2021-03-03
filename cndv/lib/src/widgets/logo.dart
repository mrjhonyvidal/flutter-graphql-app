import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  final String titulo;

  const Logo({
    Key key,
    this.titulo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 200,
        margin: EdgeInsets.only( top: 50),
        child: Column(
          children: <Widget>[
            Image( image: AssetImage('assets/img/cndv_logo.png'),),
            SizedBox(height: 20),
            Text('CNDV', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600 )),
            SizedBox(height: 20),
            Text('Carteira Nacional', style: TextStyle(fontSize: 20,)),
            Text('Digital de Vacinação', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
