import 'package:flutter/material.dart';

class CarteiraQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff526BF6),
        title: Text('QR'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        QrImage(
          data: "Sts",
          backgroundColor: Colors.blue,
          size: 200,
        )
      ])),
    );
  }
}
